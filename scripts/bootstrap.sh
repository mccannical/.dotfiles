#!/bin/bash
#
# Brief description of your script
# Copyright 2024 jesse.mccann

# Globals:
# Arguments:
#  None
main() {
  glab api '/projects/38/repository/files/bastions%2Fbastion?ref=main' | jq -r .content | base64 -d -i - > ~/bin/bastion
  chmod +x ~/bin/bastion

}
main "$@"
