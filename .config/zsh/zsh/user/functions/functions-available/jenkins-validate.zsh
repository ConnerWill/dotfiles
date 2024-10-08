# shellcheck disable=1072,2148
# https://www.jenkins.io/doc/book/pipeline/development/#linter

function jenkins-validate(){
  ## Define input file
  local jenkins_file="${1:-Jenkinsfile}"

  ## Check if Jenkinsfile exists
  [[ -f "${jenkins_file}" ]] || printf "Cannot find Jenkinsfile: %s\n" "${jenkins_file}" || return 1

  ## Check if all required variables are set
  [[ -z "${JENKINS_AUTH}" ]] && printf "JENKINS_AUTH is not defined\n" && return 1
  [[ -z "${JENKINS_URL}"  ]] && printf "JENKINS_URL is not defined\n"  && return 1

  ##  These instructions assume that the security realm of Jenkins is something other than "None" and you have an account.
  ##  JENKINS_URL=[root URL of Jenkins controller]
  ##  JENKINS_AUTH=[your Jenkins username and an API token in the following format: your_username:api_token]
  curl                                    \
    --insecure                            \
    --request POST                        \
    --user "${JENKINS_AUTH}"              \
    --form "jenkinsfile=<${jenkins_file}" \
    --url "$JENKINS_URL/pipeline-model-converter/validate"
}
