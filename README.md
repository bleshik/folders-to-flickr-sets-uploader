# Script uploading to flickr
The script requires the utility "flickcurl" to be installed.

## Example
Let's assume you have the following structure in a folder:
```
folder
|
\_ inner-folder
  |
  \_ another-inner-folder
    |
    \_ IMG1.jpg
  |
  \_ IMG0.jpg
```
"upload-sets-in-the-folder.sh folder" finds folders inside the "folder" and executes "upload-set.sh folder/inner-folder".
The script then uploads IMG0.jpg to the "inner-folder" (creates if doesn't exist) set on Flickr and IMG1.jpg to the "inner-folder. another-inner-folder" set (creates if doesn't exist).

## Usage
```bash
git clone https://github.com/bleshik/folders-to-flickr-sets-uploader.git
cd folders-to-flickr-sets-uploader
./upload-sets-in-the-folder.sh folder
```

You can safely execute the script several times, because it stores which files are uploaded.
