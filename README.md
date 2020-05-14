# arvo_log

Arvo is a little program that will you help manage your hiera environment. It requires this puppet plugin to send statistics to it.

## Usage
Arvo_log does require some setup you must add following to your hiera.yaml file. Then of course api url must also be running an arvo instance.
```
hierarchy:
  - name: "log keys"
    lookup_key: arvo_log
    options:
      api: 'http://localhost:8162/v1/keys'
      tag: "%{::trusted.certname}"
```


