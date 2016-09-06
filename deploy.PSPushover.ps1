
Deploy LocalGallery {
    By PSGalleryModule {
        FromSource PSPushover
        To PSPrivateGallery
        WithOptions @{
            ApiKey = $ENV:NugetApiKey
        }
    }
}