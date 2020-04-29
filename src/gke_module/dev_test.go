package test

import (
        "fmt"
        "log"
        "testing"
        "os"
        "bufio"
        "strings"
        "strconv"
        "time"

        "golang.org/x/net/context"
        "golang.org/x/oauth2/google"
        "google.golang.org/api/container/v1"
        "github.com/stretchr/testify/assert"
        "github.com/magiconair/properties"
        "github.com/gruntwork-io/terratest/modules/retry"
)



func TestGkeCluster(t *testing.T) {

        //GOOGLE_APPLICATION_CREDENTIALS
        var _, exist = os.LookupEnv("GOOGLE_APPLICATION_CREDENTIALS")
        if exist {
            credentialsContent := os.Getenv("GOOGLE_APPLICATION_CREDENTIALS")

            f, err := os.Create("./demo2-273713-2aec36fc29c5.json")
            if err != nil {
                fmt.Errorf("Failed in creating credential file....%s", err)
            }
            w := bufio.NewWriter(f)
            w.WriteString(credentialsContent)
            if err != nil {
                fmt.Errorf("Fail in writing into file....%s", err)
            }
            w.Flush()
            os.Setenv("GOOGLE_APPLICATION_CREDENTIALS", "/home/ash/Downloads/demo2-273713-2aec36fc29c5.json")
        }

        maxRetries := 40
        sleepBetweenretries := 3*time.Second


        //LOAD variables.tfvars file
        p := properties.MustLoadFile("../../properties/gcp-ushi-search-platform-npe/dev/live/gke/dev/variables.tfvars", properties.UTF8)

        //access variables
        project_id := strings.Replace(p.MustGetString("project_id"),"\"", "", 2)
        region := strings.Replace(p.MustGetString("region"),"\"", "", 2)
        gke_cluster_name := strings.Replace(p.MustGetString("gke_cluster_name"),"\"", "", 2)
        subnetwork_name := strings.Replace(p.MustGetString("subnetwork_name"),"\"", "", 2)
        network_name := strings.Replace(p.MustGetString("network_name"),"\"", "", 2)
        initial_node_count := strings.Replace(p.MustGetString("initial_node_count"),"\"", "", 2)

        gke_version := strings.Replace(p.MustGetString("gke_version"),"\"", "", 2)
//         max_node_count := strings.Replace(p.MustGetString("max_node_count"),"\"", "", 2)

        ctx := context.Background()
        retry.DoWithRetry(t, "fetching cluster information from google api", maxRetries, sleepBetweenretries, func() (string, error){
            cluster_api := "projects/"+project_id+"/locations/"+region+"/clusters/"+gke_cluster_name


            c, err := google.DefaultClient(ctx, container.CloudPlatformScope)
            if err != nil {
                    log.Fatal(err)
            }

            containerService, err := container.New(c)
            if err != nil {
                    log.Fatal(err)
            }

            cluster_details, err := containerService.Projects.Locations.Clusters.Get(cluster_api).Context(ctx).Do()
            if err != nil {
                    log.Fatal(err)
            }

            //Validate cluster name, subnetwork_name, network_name, Region, gke_version and Status of the cluster
            assert.Equal(t, gke_cluster_name, cluster_details.Name, "The two words should be the same.")
            assert.Equal(t, subnetwork_name, cluster_details.Subnetwork)
            assert.Equal(t,network_name, cluster_details.Network)
            assert.Equal(t,gke_version, cluster_details.CurrentNodeVersion, "The two words should be the same.")
            assert.True(t, strings.HasPrefix(cluster_details.Locations[0],region))
            assert.True(t, cluster_details.Status=="RUNNING")
            return "", nil
        })


        retry.DoWithRetry(t, "fetching node-pool information from google api", maxRetries, sleepBetweenretries, func() (string, error){
            c, err := google.DefaultClient(ctx, container.CloudPlatformScope)
            if err != nil {
                log.Fatal(err)
            }

            containerService, err := container.New(c)
            if err != nil {
                    log.Fatal(err)
            }

            node_api := "projects/"+project_id+"/locations/"+region+"/clusters/"+gke_cluster_name+"/nodePools/"+gke_cluster_name+"-node-pool"
            node_pool_details, err := containerService.Projects.Locations.Clusters.NodePools.Get(node_api).Context(ctx).Do()
            if err != nil {
                    log.Fatal(err)
            }

            InitialNodeCount:=strconv.FormatInt(node_pool_details.InitialNodeCount,10)

            //validate initial_node_count
            assert.Equal(t,gke_cluster_name+"-node-pool", node_pool_details.Name)
            assert.Equal(t,initial_node_count, InitialNodeCount, "The two words should be the same.")
            assert.True(t, node_pool_details.Status=="RUNNING")
            return "", nil
        })
        t.Log("good bye")
}
