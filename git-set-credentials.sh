#!/bin/bash
# Generate .git-credentials file based on Environment Variables

# Required:
# $GIT_USER - git Username (ex: pjfancher)
# $GIT_PASS - git Personal Access Token (https://github.com/settings/tokens)
#*****************************************************************************

 # Clear the screen
#*****************************************************************************
printf "\033c"

# Get sudo upfront
#*****************************************************************************
sudo -v

# Vars
#*****************************************************************************
GC=~/.git-credentials
ERROR=false
GREEN='\033[1;32m'
RED='\033[0;31m'
PURPLE='\033[1;35m'
NC='\033[0m'

#*****************************************************************************
# Check the needed ENV vars
#*****************************************************************************

# $GIT_USER
#*****************************************************************************
if [ -z "$GIT_USER" ]; then
  read -r -p "Git Username? [pjfancher]: " GIT_USER

  GIT_USER=${GIT_USER:-pjfancher} # https://stackoverflow.com/questions/2642585/read-a-variable-in-bash-with-a-default-value

  if [ -n "$GIT_USER" ]; then
    printf "${GREEN}\$GIT_USER is set: ${GIT_USER}${NC}\n\n"
  else
    printf "${RED}Error: Could not set \$GIT_USERi${NC}\n\n";
    ERROR=true
  fi
else
  printf "${GREEN}\$GIT_USER is set${NC}\n\n"
fi

# $GIT_PASS
#*****************************************************************************
if [ -z "$GIT_PASS" ]; then
  read -r -p "Git Token? (https://github.com/settings/tokens): " GIT_PASS

  if [ -n "$GIT_PASS" ]; then
    printf "${GREEN}\$GIT_PASS is set.${NC}\n\n"
  else
    printf "${RED}Error: Could not set \$GIT_PASS${NC}\n\n";
    ERROR=true
  fi
else
  printf "${GREEN}\$GIT_PASS is set${NC}\n\n"
fi

# Write file or Err
#*****************************************************************************
if [ "$ERROR" = true ]; then
  printf "${RED}\nERROR: Could not generate ${GC} file\nCheck your \$GIT_USER and \$GIT_PASS Environment variables.${NC}\n\n";
  exit 1
else
  # Define Credential Store Method for Git
  #*****************************************************************************
  printf "${PURPLE}Setting .git/config to cache credentials on disk at ${GC}${NC}\n\n"
  git config --global --unset credential.helper
  git config credential.helper 'store --file ~/.git-credentials'

  # Try to generate the ~/.git-credentials file
  #*****************************************************************************
  printf "https://${GIT_USER}:${GIT_PASS}@github.com" > ${GC}
  printf "${GREEN}Git Credentials stored in: ${GC}${NC}\n"
fi
