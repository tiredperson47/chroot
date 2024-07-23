## Chroot


### Description:
Chroot is a function in OpenSSH (and probably other ssh servers/clients) that makes it so the users are trapped in an isolated directory. This does NOT mean that they are in a separate file system though. They are simply trapped in a subdirectory and limited to commands that you can specify in the script.

### About the script
The script allows you to customize it for your own needs and specifications. You can customize the jail directory, group, users, and allowed commands. The code is copied from a YouTube video I found at https://youtu.be/bAjXR78FTs8?si=QA7_AuX-h6g_HhYF or "Setup SSH and SFTP server with chroot jail" by Tan En De.

I am unoriginal and can't code for my life. If something doesn't work, well shit. Good luck, and have fun debugging. 

In case you're trying to use this in a competiton like NCAE, this will not work unless they changed the scoring code since NCAE 2024. Our team tried and it didn't work. It is a cool concept to learn about though. Just don't go crazy deep into it.
