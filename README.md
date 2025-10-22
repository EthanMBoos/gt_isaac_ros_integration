# GT Sim2Real Robotics VIP: Nvidia Isaac Sim & ROS2 Integration

`gt_isaac_ros_integration` provides a unified development environment for robotics simulation. Its primary function is to populate the NVIDIA Isaac Sim environment with a library of pre-configured robot assets and scenes, along with the toolchain to build the ROS2 nodes that interact with them.

A brief overview of the key directories in this repository:
```text
.
├── gt_isaac_ros_integration
├── jazzy_ws
│   ├── launch/
│   ├── src/
│   ├── scripts/
│   ├── rviz/
│   ├── urdf/
│   ├── config/
│   └── package.xml
├── submodules/
├── dockerfiles/
├── build_ros.sh
└── README.md
```

## What It Does
This repository is an evolving toolkit designed to accelerate robotics development from simulation to the real world. The focus is on providing a robust foundation today, with a clear roadmap for advanced capabilities.
- **Multi-Domain Robotics**: Provides starter templates for a variety of platforms, including ground, aerial, and marine vehicles. Includes pre-configured examples for common tasks like autonomous navigation with Nav2 and sensor data visualization in RViz2.
- **Accelerated Training and Testing**: Integrates modern robotics workflows with templates for reinforcement learning (RL) to train complex behaviors directly in simulation. It also provides a framework for automated software-in-the-loop testing to validate every code change in a realistic physics environment, ensuring robustness before deployment.  
- **Streamlined Sim2Real Workflow**: This workspace eliminates the friction of setting up a complex simulation environment. It handles the intricacies of the Isaac Sim ROS 2 Bridge, Docker environments, and package dependencies, transforming a multi-day setup process into a simple clone-and-build experience.

`gt_isaac_ros_integration` **at a Glance**

| Feature Category | Provided by NVIDIA Isaac Sim | Provided by ROS 2 | gt_isaac_ros_integration Contribution |
|---|---|---|---|
| **Simulation** | Photorealistic, physics-accurate virtual worlds (PhysX) | N/A | Pre-configured scenes and assets. |
| **Communication** | Core ROS2 Bridge Extension | Industry-standard middleware (DDS), nodes, and topics | Launch files & configs for robust integration. |
| **Integration** | Library of robot models (URDF/USD) | Standard software stacks (Nav2, MoveIt) | Working examples for common tasks (Nav2, MoveIt). |
| **Workflow** | Python scripting APIs & UI tools | colcon build system | Unified colcon workspace for a clone-and-run experience. |


## Getting Started
To get a local copy up and running, follow these steps.

**Prerequisites**

Ensure you have the following installed and configured on your system. This project has been tested on and is designed for the environment below:
- OS: Ubuntu 22.04 LTS
- ROS 2: Jazzy Jalisco (Desktop Install)
- NVIDIA Isaac Sim: Version 2023.1.1 or later
- NVIDIA Driver: Version 535.x.x or later

"Hello world turtlebot example coming soon"

## Full Documentation

See the [Wiki](https://github.com/EthanMBoos/gt_isaac_ros_integration/wiki) for full documentation, tutorials, and guides.

See the [Sim2Real Robotics group website](https://sim2realrobotics.com/) for demo showcases and other Georgia Tech VIP team details.

## Communication

- Signal Group: [GT Sim2Real Robotics]()
- [GitHub Issues](https://github.com/EthanMBoos/gt_isaac_ros_integration/issues)
