Issue # 

# Summary of things changed:

- add route for delete user media from list
- add happy path test for deleting a single user's media from their list
- add happy path test for checking a different user's media of the same id is not deleted
- error handling sad path test for user not existing given id
- error handling sad path test for user not owning user_media given media_id
- user/media controller destroy action added

# List any known issues (include relevant code snippets):

-  example: none (crosses fingers) obvious sad paths covered

- This functionality really relies on media only being allowed to live on a single user's list at a time

# Necessary checkmarks (replace space between brackets with 'x' to check box):

- [ ]  All tests are passing
- [ ]  Code will run locally
- [ ]  Confirm self-review

# Json response snippet:
