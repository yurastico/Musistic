# Musistic

## About Musistic
Musistic is an application designed to track your Spotify listening activity. I decided to create and keep it open-source because other apps that perform similar functions are not particularly good and come with numerous advertisements. My desire to develop iOS applications is to create tools that are useful specifically for me, meeting my needs perfectly. If it happens to benefit someone else, that would be perfect!

### Setting up project

To build app in your xcode you need to create a enum called *SpotifyConstants*

```swift 
enum SpotifyConstants: String {
    case clientId = "{YOUR CLIENT ID}"
    case scope = "user-read-private user-read-email user-top-read"
}
```
You dont need expose your client secret, just the clientId, im showing my client secret in this project, but is recommended dont show this information
