{# This is a formula. It works by loading a jinja template for default config values which then merges in pillar for overrides. #}
{% from "saltycontainer/map.jinja" import sc_settings with context %}

service-factory-code:
  git.latest:
    - name: {{ sc_settings.git_repo }}
    - rev: {{ sc_settings.git_rev }}
    - target: {{ sc_settings.git_target }}

service-factory-install:
  cmd.run:
    - name: {{ sc_settings.install_command }}
    - cwd: {{ sc_settings.install_cwd }}
    - creates: {{ sc_settings.install_creates }}
    - require:
      - git: service-factory-code

service-factory-start:
  cmd.run:
    - name: {{ sc_settings.start_command }}
    - creates: {{ sc_settings.start_creates }}
    - require:
      - git: service-factory-code
      - cmd: service-factory-install

service-factory-check:
  cmd.run:
    - name: {{ sc_settings.check_command }}
    - require:
      - cmd: service-factory-start
