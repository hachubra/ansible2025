# Ansible Role: clickhouse
[![License](https://img.shields.io/badge/license-MIT%20License-brightgreen.svg)](https://opensource.org/licenses/MIT)

## Description

Deploy [lighthouse](https://lighthouse-book.sigmaprime.io/intro.html) automated auditing, performance metrics, and best practices for the web using ansible.

## Requirements

- Ansible >= 2.11 (It might work on previous versions, but we cannot guarantee it)
- Debian and python on deployer machine.

## Example

### Playbook

```yaml
---
- name: LIGHTHOUSE
  hosts: lighthouse
  roles:
    - role: lighthouse-role
      tags: lighthouse

```

## License

This project is licensed under MIT License. See [LICENSE](/LICENSE) for more details.


## Author Information

[lighthouse](https://lighthouse-book.sigmaprime.io/intro.html) by `Google, Inc.`

Role by `Alex S`.