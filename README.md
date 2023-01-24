# ipb-charts-public
Packaging of applications for Kubernetes as Helm charts or Rancher Apps

## Configurable values

Only a few properties *have* to be configured for each site and installation:

## MetFrag

You can install the MetFrag web applications

During the very first installation, the postgres file is filled
with (among others) the PostGres database. This can take around six hours,
depending on the speed and I/O in your kubernetes cluster. Since that data
will be persisted, subsequent starts are much faster. Note: if you allow
rancher/helm to create a random app name (and not a fixed, say "metfrag"),
EACH initialisation will create its own database, taking hours to fill.

### Hostname for the ingress

The apps such as MetFrag will be available at a particular URL,
and the hostname has to be declared as `webfqdn` (using the fully qualified domain name FQDN).

Similarly, the apps MAY be served at a particular path,
especially if you are using a reverse proxy to multiplex/route
the incoming traffic to different services. The path has to be
declared as `webpath` (currently without trailing slash, not sure if that
  is a requirement).

The full URL then becomes http(s)://webfqdn/webpath
For a root configuration use "/".

### Configuring Lets Encrypt tls

To enable Lets Encrypt https certificates, you need to provide
1) a valid eMail (not some @example.com address) and a real DNS name,
i.e. `metfrag.u.v.w.x.nip.io` usually won't work. Also, you need
a working cert-manager in your K8S cluster.

## Usage with Helm

Helm (https://helm.sh/) is a package manager for Kubernetes applications,
which are described and installed through so-called charts. Charts are hosted
locally or in repositories.

First add the IPB charts repo to your helm:
```
helm repo add ipb-public https://ipb-halle.github.io/ipb-charts-public/
```

Then install e.g. MetFrag into the Kubernetes metfragbeta namespace:
```
helm install metfrag --values metfrag-beta.yaml -n metfragbeta ipb-public/metfrag
```
