# iOS仿微信聊天页面长按气泡弹窗，wechat similar bubble or popup menu

![效果](https://img-blog.csdnimg.cn/446b728e230248a7870cf1978b1b273a.png?x-oss-process=image/watermark,type_d3F5LXplbmhlaQ,shadow_50,text_Q1NETiBAeWFuZ2ppZXNlYWd1bGw=,size_20,color_FFFFFF,t_70,g_se,x_16){:width="585px" height="565px"}

显示效果图如上，👇下面有gif

## ⏰‼️‼️如何使用？

* 代码地址：https://github.com/JackYoung1989/WechatSimilarBubbleMenu.git

* 将代码拉下来，将JYBubbleButtonModel、JYBubbleMenuView、JYTextView三个类添加到您的工程中，然后将原来显示聊天内容的textView继承JYTextView即可。

## ⏰‼️‼️能够帮到你什么？

* 该设计方式是通过继承UITextView的方式，通过监听delegate，获取并计算出所选中文本的frame，然后确定弹出框的位置。通过选中文本的开始点，通过一系列计算，确定弹出气泡的箭头的位置。且可以通过设定变量，来控制气泡在选中文本中的优先位置，优先显示在文本的上面，还是下面。

## ⏰‼️‼️对原来代码有什么影响？

* 本实现方式对原来代码没有侵入性，基本上保证了代码的低耦合性，仅仅将来源继承UITextview的文本显示框，重新继承JYTextView即可。

## ⏰‼️‼️在使用过程中遇到问题怎么办？

* 可以通过github issue我，或者给我邮件yangjieseagull@163.com

## ⏰‼️‼️如果该代码确实帮到您，想给予反馈？

* 请帮我在github上，点一个小星星✨，谢谢

![效果](https://img-blog.csdnimg.cn/6cbebc191ebe406d9d12bfcdcec5d63b.gif)


