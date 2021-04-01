1. Start the Artifactory docker container
	docker start artifactory
2. In the UI, empty any 'cache' repositories as required
	http://localhost:8082/ui/packages
3. Making sure gradle is configured to go through local Artifactory, do a full build e.g.
    ./gradlew goJF build jacocoTestReport
4. Delete existing repository export
    ./cleanExport.sh
4. In the UI, under settings, export repositories
	a. choose: All Repositories
	b. to: /var/opt/jfrog/artifactory/export/
	c. exclude metadata
5. Need to update permissions on exports
    ./updateExport.sh

Now 'repo_base' is the base repository (image of last export)
deps_catalog_repo_<date>.txt are the sorted catalog of repo contents for base repos.
(deps_catalog_repo_210304.txt is the original from Flamingo for final comparison,
deps_catalog_repo_orig.txt and repo_orig are the original bases)

6. Copy the new export locally
    cp -r ~/Working/artifactory/var/export/repositories ./repo_new
    
7. Create the difference 
    rm -rf repo_diffs
    ./moveDiffs.sh repo_new repo_base repo_diffs_<date>
    
8. Create a catalog of repo_diffs_<date>
    ./createRepoCatalog.sh repo_diffs_<date>
    
Confirm the catalog of additions is ok, sensible, and justifyable.
The repo_diffs_<date> folder can be tar's and zipped ready for sending to PF.

The repo_diffs_<data> catalog is used to create the ticket on confluence.
It can be sent to your bank email as it does not contain any project information, just listings of publicly available components.

9. Prep for next time
    Date and archive the existing deps_catalog_repo_base.txt as deps_catalog_repo_base_<date>.txt
    Remove repo_base and replace with repo_new
    Create a new repo_base catalog
    Archive the dated diff catalog
    
    

