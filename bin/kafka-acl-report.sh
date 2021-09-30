#!/usr/bin/env bash
#set -x
DBGLEVEL=0

APPPATH=`dirname $0`
source ${APPPATH}/functions.sh

declare -A arrayUser
# ----------------------------------------------------------------------------
function reportByUser {
  debug 5 "Entering function reportTopic"
  user=$1
  var1=${arrayUser[$user]}
  debug 3 "User=${user} ==> [${var1}]"
  set -f
  entry=(${var1//:/ })
  echo "The ACL for USER ${user} are ... "
  for K in "${!entry[@]}"; do
    debug 5 "$K --- ${entry[$K]}"
    aclEntry=(${entry[$K]//;/ })
    # TOPIC;adl-e00-pub-sa-gateway_response-t-uat;LITERAL;*;READ;ALLOW
    echo "   On ${aclEntry[0]} ${aclEntry[1]} (${aclEntry[2]}) has ${aclEntry[4]} ${aclEntry[5]} from HOST ${aclEntry[3]}"
  done

  debug 5 "Exiting function reportTopic"
}
# ----------------------------------------------------------------------------
function getUser {
  debug 5 "Entering function getTopic"
  #
  ### fnInput="${APPPATH}/../sample/small.acls"
  while IFS= read -r line
  do
    debug 5 "Got line : [$line]"
    # --------------------------------------------------------------------------------------------
    # Matching Current Resource ACLs
    pattern='Current\ +ACLs\ +for\ +resource\ +\`ResourcePattern\(resourceType=(.*),\ +name=(.*),\ +patternType=(.*)\)\`'
    if [[ $line =~ ${pattern} ]]; then
      aclResourceType=${BASH_REMATCH[1]}
      aclResourceName=${BASH_REMATCH[2]}
      aclResourcePatternType=${BASH_REMATCH[3]}
      debug 3 "Matching ACLs resource ResourceType=[${aclResourceType}] ResourceName=[${aclResourceName}] ResourcePatternType=[${aclResourcePatternType}]"
    fi
    # --------------------------------------------------------------------------------------------
    # Matching Principal ACLs
    #         (principal=User:fidapp-it-sams-uat, host=*, operation=WRITE, permissionType=ALLOW)
#   pattern='.*\(principal=User:(.*),\ +host=(.*),\ +operation=(.*),\ +permisssionType=(.*)\)'
    pattern='.*\(principal=User:(.*),\ +host=(.*),\ +operation=(.*),\ +permissionType=(.*)\)'
    if [[ $line =~ ${pattern} ]]; then
      aclPrincipal=${BASH_REMATCH[1]}
      aclHost=${BASH_REMATCH[2]}
      aclOperation=${BASH_REMATCH[3]}
      aclPermissionType=${BASH_REMATCH[4]}
      debug 3 "Matching ACLs Principal Principal=[${aclPrincipal}}] Host=[${aclHost}] Operation=[${aclOperation}] Permmission=[${aclPermissionType}]"

      if [[ -z "${arrayUser[${aclPrincipal}]}" ]]; then
        debug 3 "First entry for User ${aclPrincipal}"
        arrayUser[$aclPrincipal]="${aclResourceType};${aclResourceName};${aclResourcePatternType};${aclHost};${aclOperation};${aclPermissionType}"
      else
        debug 3 "Subsequent entry for User ${aclPrincipal}"
        arrayUser[$aclPrincipal]="${User[$aclPrincipal]}:${aclResourceType};${aclResourceName};${aclResourcePatternType};${aclHost};${aclOperation};${aclPermissionType}"
      fi
    fi
    # --------------------------------------------------------------------------------------------
  done < "${optFn:-/dev/stdin}"

  debug 5 "Exiting function getTopic"
}
# ----------------------------------------------------------------------------

usage() { echo "Usage: $0 -u <user> [-f <filename> | STDIN]" 1>&2; sleep 5; exit 1; }

# ----------------------------------------------------------------------------
# Parse and validate commandline arguments
while getopts "f:u:h" o; do
    case "${o}" in
        u)
            optUser=${OPTARG}
            ;;
        f)
            optFn=${OPTARG}
            if [ ! -f ${optFn} ]; then
              echo "[ERROR] Filename |${optFn}| not found. Exit"
              usage
            fi
            ;;
        h)
            usage
            ;;
        *)
            usage
            ;;
    esac
done
shift $((OPTIND-1))

#if [ -z "${optUser}" ] && [ -z "${optGroup}" ]; then
if [ -z "${optUser}" ]; then
    echo "[ERROR] Missing \"-u <username>\". Exit"
    usage
fi

debug 5 "Commandline arguments optUser = [${optUser}]"
# ----------------------------------------------------------------------------
if [ ! -z "${optUser}" ]; then
  debug 5 "Calling getTopic"
  getUser
  reportByUser ${optUser}
fi

debug 5 "Script complete. Exiting."

