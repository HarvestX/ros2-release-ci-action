# ros2-release-ci-action
ROS2 Version Control CI actions


## Usage
```yml
name: release
on:
  workflow_dispatch:
    inputs:
      fragment:
        type: choice
        description: Semantic version target
        options:
          - bug
          - feature
          - major
jobs:
  release:
    name: Release
    runs-on: ubuntu-latest
    steps:
      - name: Upgrade version
        id: upgrade
        uses: HarvestX/ros2-release-ci-action@main
        env:
          GITHUB_TOKEN: ${{ secrets.GITHUB_TOKEN }}
        with:
          target-package: 'your_ros2_pkg_name'
          version-fragment: ${{ github.event.inputs.fragment }}
          create-release: 'true'
```

### Input parameters
|      **name**      |                   **description**                    | **default** | **required** |
| :----------------: | :--------------------------------------------------: | :---------: | :----------: |
|    `target-pkg`    | The target ROS2 package name to bump up the version. |   *None*    |    *True*    |
| `version-fragment` |         The versions fragment to increment.          |   *None*    |    *True*    |
|  `create-release`  |          Create Github release page or not.          |   'false'   |    *False*    |
