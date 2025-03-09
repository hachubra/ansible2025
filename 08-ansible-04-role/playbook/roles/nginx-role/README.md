# Ansible Role: nginx
[![License](https://img.shields.io/badge/license-MIT%20License-brightgreen.svg)](https://opensource.org/licenses/MIT)

## Description

Deploy [Vector](https://www.nginx.com/) мost popular http server using ansible.

## Requirements

- Ansible >= 2.11 (It might work on previous versions, but we cannot guarantee it)
- Debian and python on deployer machine.


## Example

### Playbook

```yaml
---
- name: NGINX
  hosts:
    - lighthouse
  become: true
  roles:
    - role: nginx-role
      tags: nginx
```

## License

This project is licensed under MIT License. See [LICENSE](/LICENSE) for more details.


## Author Information

[NGINX](https://www.nginx.com/products/nginx/compare-models/) by [F5, Inc.](https://www.nginx.com/about/).

Role by `Alex S`.