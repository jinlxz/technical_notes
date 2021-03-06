Jenkins configurations
---
groovy statements can be used directly in a pipeline.
1. pipeline basic structure
```java
node("agent-label"){
    def xxxx=""
    stage("checkout src"){
        //statements here.
    }
    stage("xxxx"){
        // tasks running in parallel.
        parallel deploy_a:{
        },
        deploy_b:{
        },
        deploy_c:{
        }
    }
    try{
       stage("xxx"){
          node("agent-label"){
              // statements here.
          }
       }
       stage("xxx"){
       
       }
    }catch(Exception e){
       ....
    }finally{
      echo "hello, test finished."
    }
}
```
3. get environment variables in pipeline.
```
def buildEnvVars(){
    sh 'env > env.txt' 
    def envVars=[:];
    for (String i : readFile('env.txt').split("\n")) {
        envs=i.split("=");
        envVars.put(envs[0],envs[1]);
    }
    return envVars;   
}
```
also `env` object can be accessed in a pipeline directly
- env["WORKSPACE"]
- "${env.WORKSPACE}" // referenced in string.
- if(env.xxx.equals("")){ }  // referenced with groovy syntax.
3. parameterize a pipeline project.
```
parameters([booleanParam(defaultValue: true, description: '', name: 'SKIP_DEPLOYMENT')])])
```
4. set properties on a pipeline project.
```
properties([disableConcurrentBuilds(), [$class: 'RebuildSettings', autoRebuild: false, rebuildDisabled: false],
```
5. parse = separated properties of string into `Properties` object
```
Properties parsePropertiesString(String s) {
  // grr at load() returning void rather than the Properties object
  // so this takes 3 lines instead of "return new Properties().load(...);"
  final Properties p = new Properties();
  p.load(new StringReader(s));
  return p;
}
```
6. generate list of changed files
```
def genListOfChangedFiles(){
  def changedFiles=""
  changedFiles+="List of changed files:<br/>"
  def changeLogSets = currentBuild.changeSets
  for (int i = 0; i < changeLogSets.size(); i++) {
    def entries = changeLogSets[i].items
    changedFiles+="<ol>"
    for (int j = 0; j < entries.length; j++) {
      changedFiles=changedFiles+"<li>"
      def entry = entries[j]
      changedFiles+="${entry.commitId} by ${entry.author} on ${new Date(entry.timestamp)}: ${entry.msg}<ul>"
      def files = new ArrayList(entry.affectedFiles)
      for (int k = 0; k < files.size(); k++) {
        def file = files[k]
        changedFiles+="<li> ${file.editType.name} ${file.path}</li>"
      }
      changedFiles+="</ul></li>"
    }
    changedFiles+="</ol>"
  }
  return changedFiles
}
```
7. pass arguments to template of email-ext plugin
```java
import java.io.*
def envVars = build.getEnvironment(listener);
def extraEnv=envVars["JENKINS_HOME"]+"/"+ envVars["JOB_BASE_NAME"]+"_"+envVars["BUILD_NUMBER"]
def envFile=new File(extraEnv);
if(envFile.exists()){
   def env_content=envFile.getText("UTF-8")
   parseTextToMap(env_content,envVars,"")
}
def parseTextToMap(String text,Map map,String defaultValue){
    def temp_list=text.split("\n")
    for(line in temp_list){
      def entry=line.split("=")
      map.put(entry[0],entry.size()==2?entry[1]:defaultValue)
    }
    return map
}
```
8. pipeline for executing multiple jobs programmatically in parallel.
```java
properties([
    parameters([string(name: 'AGENT_NUM', defaultValue: '2', description: 'the tag of environment configuration to build.'),
    ])
]);
def AGENT_LABEL="jmeter-slave-azure-i2t";
def AGENT_NUM=env.AGENT_NUM;
echo "AGENT_NUM ==> ${env.AGENT_NUM}"
def agentList=[:];
def agentIpList=[];
for(int i=0;i<Integer.valueOf(AGENT_NUM);i++){
    agentList[i]={
        node(AGENT_LABEL){
            checkout([$class: 'GitSCM', branches: [[name: 'uidwl']], doGenerateSubmoduleConfigurations: false, extensions: [], submoduleCfg: [], userRemoteConfigs: [[credentialsId: 'git_lab', url: 'git@github.com:test.git']]])
            def rc=sh label: '', returnStatus: true, script: '''
                chmod +x ./mvnw
                ./mvnw clean package -DskipTests > /dev/null 2>&1
            '''
            /*
            if(rc==0)
                echo "set up agent ${env.HOST_NAME} successfully"
            else
                error "Failed to set up agent."
            */
            //def ip=println InetAddress.localHost.canonicalHostName;
            agentIpList.add(InetAddress.localHost.hostAddress);
        }
    }
}
stage("set up agent"){
    parallel agentList
    println agentIpList;
}
```
9. use separate git key in jenkins
```shell
echo "ssh -i ${GIT_KEY}"' $1 $2' > git_ssh.sh 
chmod +x git_ssh.sh
GIT_SSH="${WORKSPACE}/git_ssh.sh" git lfs pull origin ${BRANCH_NAME}
```
