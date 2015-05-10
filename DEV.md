# DrawCrowd-iOS
An iOS browser for DrawCrowd.

## API
1. 栏目
    1.1. 创意聚焦
    http://drawcrowd.com/creative_spotlight/total                      总数 
    http://drawcrowd.com/creative_spotlight?offset=0                   offset为24，注意必要的headers 

    1.2. 人气榜
    每日（daily），每周（weekly），每月（monthly）
    http://drawcrowd.com/rankings?offset=0&type=daily                   offset为40
    http://drawcrowd.com/rankings?offset=40&type=daily&date=2015-05-04

    1.3. 为您推荐

    1.4. 新的发现
    http://drawcrowd.com/new_discoveries?page=1&cat=featured            offset为24

2. 热门标签（搜索）
http://services.drawcrowd.com/services/popular_tags

3. Project
    3.1. 批量查询
    http://drawcrowd.com/projects?ids%5B%5D=88849&ids%5B%5D=26789
    
    3.2. 评论
    http://drawcrowd.com/projects/272333/project_comments

4. User
    4.1 批量查询
    http://drawcrowd.com/users?ids%5B%5D=11730&ids%5B%5D=15521
    
    4.2 登录

    4.3 注册

5. Crowds (社团)
    5.1 单个查询
    http://drawcrowd.com/crowds/medieval

## 开发计划
- [x] 实现左侧侧边栏
- [x] 实现栏目『新的发现』
- [ ] 实现栏目『人气榜』
- [ ] 实现页面『设置』
- [ ] 实现清除缓存 -『设置』
- [ ] 实现只在wifi下载图片 -『设置』
- [ ] 实现可选图片下载分辨率 -『设置』
- [ ] 实现『搜索』功能
- [ ] 实现『收藏』功能
- [ ] 展示评论
- [ ] 展示用户名和头像
- [x] 左侧侧边栏换成『XLPagerTabStrip』
- [ ] Icon
- [ ] 应用名字、简介
- [ ] 首屏介绍页面
- [ ] 发布































