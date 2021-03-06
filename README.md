# Script uploading to flickr
The script requires the utilities "exiftool" and "flickcurl" to be installed and set up (see https://github.com/dajobe/flickcurl for more information).

## Example
Let's assume you have the following structure in a folder:
```
folder
|
\_ inner-folder
  |
  \_ another-inner-folder
  | |
  | \_ IMG1.jpg
  |
  \_ IMG0.jpg
```
"upload-sets-in-the-folder.sh folder" finds folders inside the "folder" and executes "upload-set.sh folder/inner-folder".
The script then uploads IMG0.jpg to the "inner-folder" (creates if doesn't exist) set on Flickr and IMG1.jpg to the "inner-folder. another-inner-folder" set (creates if doesn't exist).

## Usage
### Console
```bash
git clone https://github.com/bleshik/folders-to-flickr-sets-uploader.git
cd folders-to-flickr-sets-uploader
./upload-sets-in-the-folder.sh folder
```
You can safely execute the script several times, because it stores which files are uploaded.
### Crontab
Get the script and edit your crontab configuration file with:
```bash
git clone https://github.com/bleshik/folders-to-flickr-sets-uploader.git
crontab -e
```
And add the following (change the "~/Pictures/Photos" to whatever you have):
```bash
*/10 * * * * ~/folders-to-flickr-sets-uploader/upload-sets-in-the-folder.sh ~/Pictures/Photos >> /tmp/flickr.log 2>&1
```
Logs will be available in "/tmp/flickr.log"

### You backed up your pics. What's next?
Yeah, also you can download any set. Let's say you have a set "SET".
Then just do this:
```bash
./download-set.sh SET
```
You will have a directory called "SET" with all your pics from the set with original sizes.
