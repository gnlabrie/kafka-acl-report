
function debug {
  local level=$1
  local msg=$2
  if [[ ("${level}" -le "${DBGLEVEL}") || (-z "${DBGLEVEL}") ]]; then
    >&2 echo "`date` [${level}] ${msg}"
  fi
}