# README

### Initial project

1. bundle install
2. rails db:migrate
3. rails db:seed


```
# first login
@tokens = JSON.parse RestClient.post 'http://localhost:3000/login', name: 'user1', password: '123456'

def refresh_access_and_get_posts
  new_tokens = JSON.parse RestClient.post 'http://localhost:3000/refresh', {}, { 'X-Refresh-Token': @tokens['tokens']['refresh'] }
  posts = JSON.parse RestClient.get 'http://localhost:3000/posts', { Authorization: "Bearer #{new_tokens['access']}"}
end

# it works normal
10.times {
  refresh_access_and_get_posts
}

# 401 will be returned when get posts
10.times{
  Thread.new {
    refresh_access_and_get_posts
  }
}
```
