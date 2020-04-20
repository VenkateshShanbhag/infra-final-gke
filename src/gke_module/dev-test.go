package main

// BEFORE RUNNING:
// ---------------
// 1. If not already done, enable the Kubernetes Engine API
//    and check the quota for your project at
//    https://console.developers.google.com/apis/api/container
// 2. This sample uses Application Default Credentials for authentication.
//    If not already done, install the gcloud CLI from
//    https://cloud.google.com/sdk/ and run
//    `gcloud beta auth application-default login`.
//    For more information, see
//    https://developers.google.com/identity/protocols/application-default-credentials
// 3. Install and update the Go dependencies by running `go get -u` in the
//    project directory.

import (
        "fmt"
        "log"
        "testing"

        "golang.org/x/net/context"
        "golang.org/x/oauth2/google"
        "google.golang.org/api/container/v1"
        "github.com/stretchr/testify/assert"
        "github.com/magiconar/properties"
)

func main() {
        t := &testing.T{}
        assert := assert.New(t)
        ctx := context.Background()

        c, err := google.DefaultClient(ctx, container.CloudPlatformScope)
        if err != nil {
                log.Fatal(err)
        }

        containerService, err := container.New(c)
        if err != nil {
                log.Fatal(err)
        }

        // Deprecated. The Google Developers Console [project ID or project
        // number](https://support.google.com/cloud/answer/6158840).
        // This field has been deprecated and replaced by the name field.
        projectId := "demo2-273713" // TODO: Update placeholder value.

        // Deprecated. The name of the Google Compute Engine
        // [zone](/compute/docs/zones#available) in which the cluster
        // resides.
        // This field has been deprecated and replaced by the name field.
        // zone := "us-east4" // TODO: Update placeholder value.
        zone := "us-east4-a"
        // Deprecated. The name of the cluster to retrieve.
        // This field has been deprecated and replaced by the name field.
        clusterId := "cluster-1"

        resp, err := containerService.Projects.Zones.Clusters.Get(projectId, zone, clusterId).Context(ctx).Do()
        if err != nil {
                log.Fatal(err)
        }

        // TODO: Change code below to process the `resp` object:
        assert.Equal(t, "cluster-", resp.Name, "The two words should be the same.")
        fmt.Printf("%#v\n", resp.Name)
        fmt.Printf("%#v\n", resp.Subnetwork)
        fmt.Printf("%#v\n", resp.Network)
}
