sysstat:
  pkg.installed

/etc/default/sysstat:
  file.managed:
    - source: salt://sysstat/sysstat_conf

restart.sysstat:
  service.running:
    - name: sysstat
    - watch:
      - file: /etc/default/sysstat
