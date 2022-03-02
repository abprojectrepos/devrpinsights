cd C:\TEST\watcher\decrypt
for /r %%i in (*.gpg) do gpg --passphrase P@ssw0rD123123 --decrypt-files %%i