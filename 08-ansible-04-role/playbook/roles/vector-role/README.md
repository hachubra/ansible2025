# Ansible Role: vector
[![License](https://img.shields.io/badge/license-MIT%20License-brightgreen.svg)](https://opensource.org/licenses/MIT)

## Description

Deploy [Vector](https://vector.dev) A lightweight, ultra-fast tool for building observability pipelines using ansible.

## Requirements

- Ansible >= 2.11 (It might work on previous versions, but we cannot guarantee it)
- Debian and python on deployer machine.

## Role Variables

All variables which can be overridden are stored in [defaults/main.yml](defaults/main.yml) file as well as in table below.

| Name           | Default Value | Description                        |
| -------------- | ------------- | -----------------------------------|
| `vector_version` | 0.31.0 | Vector package version. |

## Example

### Playbook

```yaml
---
- name: VECTOR
  hosts:
    - vector
  roles:
    - role: vector-role
      tags: vector
```

## License

This project is licensed under MIT License. See [LICENSE](/LICENSE) for more details.


## Author Information

[Vector](https://vector.dev/docs/) by [DATALOG](https://www.datadoghq.com/about/leadership/).

Role by `Alex S`.