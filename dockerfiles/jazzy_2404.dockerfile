# --- Stage 1: Base OS and Locale ---
ARG BASE_IMAGE=ubuntu:24.04
FROM ${BASE_IMAGE} AS base
ENV DEBIAN_FRONTEND=noninteractive

# Configure locale
RUN apt-get update && \
    apt-get install -y --no-install-recommends \
        locales && \
    locale-gen en_US.UTF-8 && \
    update-locale LC_ALL=en_US.UTF-8 LANG=en_US.UTF-8 && \
    rm -rf /var/lib/apt/lists/*
ENV LANG="en_US.UTF-8"
ENV LANGUAGE="en_US:en"
ENV LC_ALL="en_US.UTF-8"


# --- Stage 2: ROS Repo Setup ---
# This layer is cached and only re-runs if the base image changes
FROM base AS ros-repo
ENV ROS_DISTRO=jazzy

# Install tools needed to add repo and add the ROS 2 repo
RUN apt-get update && \
    apt-get install -y --no-install-recommends \
        ca-certificates \
        curl \
        gnupg \
        lsb-release && \
    curl -sSL https://raw.githubusercontent.com/ros/rosdistro/master/ros.key -o /usr/share/keyrings/ros-archive-keyring.gpg && \
    echo "deb [arch=$(dpkg --print-architecture) signed-by=/usr/share/keyrings/ros-archive-keyring.gpg] http://packages.ros.org/ros2/ubuntu $(lsb_release -cs) main" | tee /etc/apt/sources.list.d/ros2.list > /dev/null && \
    rm -rf /var/lib/apt/lists/*


# --- Stage 3: ROS Core Installation ---
# This layer installs the main, stable ROS packages.
# It will be cached and not rebuilt unless the repo changes.
FROM ros-repo AS ros-core

RUN apt-get update && \
    apt-get install -y --no-install-recommends \
        ros-jazzy-desktop \
        python3-rosdep \
        python3-vcstool \
        python3-colcon-common-extensions \
        ros-dev-tools \
        git && \
    # Initialize rosdep
    rosdep init && \
    rosdep update --rosdistro ${ROS_DISTRO} && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/*


# --- Stage 4: Final Image with App-Specific Packages ---
# This layer installs your project-specific dependencies.
# This is the layer you will most likely rebuild as you add packages.
FROM ros-core AS final

# Install TurtleBot3 and Gazebo simulator packages
RUN apt-get update && \
    apt-get install -y --no-install-recommends \
        # This metapackage pulls in turtlebot3_msgs, bringup, etc.
        ros-jazzy-turtlebot3 \
        # This metapackage pulls in turtlebot3_gazebo
        ros-jazzy-turtlebot3-simulations \
        # This metapackage pulls in ros-gz-bridge, -sim, etc.
        ros-jazzy-ros-gz \
        # GUI runtime dependencies for X11 forwarding
        libgl1 \
        libglx-mesa0 \
        libx11-6 && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/*

# --- Configuration ---

# Configure Automatic Sourcing and Environment Variables
RUN echo "source /opt/ros/${ROS_DISTRO}/setup.bash" >> /root/.bashrc && \
    echo "[ -f /jazzy_ws/install/setup.bash ] && source /jazzy_ws/install/setup.bash" >> /root/.bashrc && \
    echo "export TURTLEBOT3_MODEL=burger" >> /root/.bashrc

# --- Workspace & CMD ---
WORKDIR /jazzy_ws
CMD ["bash"]
