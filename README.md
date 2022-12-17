# echo.ios

This is an example of how to use [echo.api](https://github.com/tom-e-kid/echo-api) and it's helper tool: [echo.toolbox](https://github.com/tom-e-kid/echo-toolbox).

## Requirements
* Xcode >= 14.0
* iOS >= 16.0

## So? what's the point?
Sometimes or maybe many times, we as a developer need DUMMY DATA right?  
and it must be useful if these data are more dynamic and more predictable and even more real.  
In those situations, [echo.api](https://github.com/tom-e-kid/echo-api) for you.

Here is an example of infinite paging list view.  
You can define your expected responses from your api as json files in your app's bundle (I call these files scenes.).  

In this case, I have defined two cases "fist-page" and "last-page" in [the scene](https://github.com/tom-e-kid/echo-ios/blob/main/echo-ios/Scene/messages.json).  
***NOTE: each case has been written as structured bodies (see 👉 [echo.api](https://github.com/tom-e-kid/echo-api) again).***

And then, with scenes and power of [toolbox](https://github.com/tom-e-kid/echo-toolbox), you can easily send your expected responses to echo.api and get these responses back from it.

it is something like these...

get first page
```
func refresh() async throws {
    let result = try await Toolbox.shared.echo(
        MessagesResponse.self,
        ErrorResponse.self,
        scene: "messages",
        case: "first-page"
    )
    switch result {
    case .success(let res):
        messages = res.messages
        pageInfo = res.page
    case .failure(let res):
        throw res
    }
}
```    

and second(last) page
```
func page() async throws {
    let result = try await Toolbox.shared.echo(
        MessagesResponse.self,
        ErrorResponse.self,
        scene: "messages",
        case: "last-page"
    )
    switch result {
    case .success(let res):
        messages += res.messages
        pageInfo = res.page
    case .failure(let res):
        throw res
    }
}
```

The advantage of this approach is that...
* You can design and test your data models on your own pace (means You don't need to care about backend's progress of development).
* You don't need to care about any other tools than your favorite tool (Xcode 💕).

## See also
[echo.api: playground](https://echo-api-sigma.vercel.app)    
[echo.api](https://github.com/tom-e-kid/echo-api)  
[echo.images](https://github.com/tom-e-kid/echo-images)  
[echo.toolbox](https://github.com/tom-e-kid/echo-toolbox)
