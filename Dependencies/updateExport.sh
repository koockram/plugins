cd ~/Working/artifactory/var
sudo chmod 777 export
cd export
echo "Working in:" `pwd`
ls
sudo find repositories -exec chmod o+r {} \; -type d -exec chmod o+x {} \;
