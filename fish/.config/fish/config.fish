set EDITOR nvim
set VISUAL nvim
set fish_greeting ""

set PATH node_modules/.bin $PATH

# Local config.
if [ -f ~/.local.fish ]
  . ~/.local.fish
end

#alias vim "nvim"

alias run_excel_importer "env SQS_CDN_PUBLISH_QUEUE=cm-cdn-publish-jasonh SQS_IMPORT_QUEUE=cm-excel-import-jasonh S3_BUCKET=cmexcel-filestorage-jasonh SNS_IMPORT_TOPIC=arn:aws:sns:eu-west-1:657464860012:cm-excel-import-jasonh CACHE_HOST=redispreview.local CACHE_PORT=6378 CAPI_URL=http://capi.local:81 FILESIZE_URL=http://filesize.local:88 python3 importer.py"
