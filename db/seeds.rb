Group.create([
  {name:"Universe",description:"Super Admin Group",active:1},
  {name:"Administrator",description:"Administrator Group",active:1},
  {name:"Author",description:"Author Group",active:1},
  {name:"User",description:"User Group",active:1},
  {name:"Anonymous",description:"Anonymous Group",active:1}
])

User.create([
  {group_id: 1, name:"root", email:"root@root.com", telphone:"18888888888", password:"root",password_confirmation:"root"},
  {group_id: 2, name:"admin", email:"admin@admin.com", telphone:"1666666666", password:"admin",password_confirmation:"admin"},
  {group_id: 3, name:"author", email:"author@author.com", telphone:"15555555555", password:"author",password_confirmation:"author"},
  {group_id: 4, name:"user", email:"user@user.com", telphone:"13333333333", password:"user",password_confirmation:"user"},
  {group_id: 5, name:"test", email:"test@test.com", telphone:"12222222222", password:"test",password_confirmation:"test"},
])

Category.create([
  {name: "首页",description: "默认的首页" },
])

Article.create( user_id: 1, category_id: 1, title:"潮汐 · 从今开始", content:"当你看到这篇文章，说明网站已经构建好了。<br/>#{Time.now.strftime('%Y/%m/%d %H:%M:%S')}\n" )
