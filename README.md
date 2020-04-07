# ipb-charts-public
Packaging of applications for Kubernetes as Helm charts or Rancher Apps

## Configurable values

Only a few properties *have* to be configured for each site and installation:

### Hostname for the ingress

The apps such as MetFrag will be available at a particular URL,
and the hostname has to be declared as `webfqdn` (using the fully qualified domain name FQDN).

Similarly, the apps MAY be served at a particular path,
especially if you are using a reverse proxy to multiplex/route
the incoming traffic to different services. The path has to be
declared as `webpath` (currently without trailing slash, not sure if that
  is a requirement).

The full URL then becomes http(s)://webfqdn/webpath





## Usage with Helm

help pleeze !

## Usage with Rancher

Rancher (https://rancher.com/) is a Kubernetes distribution and management system.
Their concept of "Apps" is built upon the ideas in Helm, and in general Helm charts should be compatible and deployable as Rancher "Apps".

### Command Line Interface (CLI)

The rancher CLI (https://rancher.com/docs/rancher/v2.x/en/cli/)
allows to add this repository as App catalog and to install MetFrag:

```
rancher catalog add --branch master ipb-charts-public https://github.com/ipb-halle/ipb-charts-public.git
```

Once the catalog is imported, you can install MetFrag with
```
rancher app install metfrag
```

### Rancher Web GUI

In the GUI you follow similar steps, adding the Catalog first:

![Adding the GitHub with IPB charts](images/ScreenshotCatalogAdd.png)

Then you can search for MetFrag
![Apps available for installation](images/ScreenshotAppInstall1.png)

and install
![Customise and Install MetFrag](images/ScreenshotAppInstall2.png)
