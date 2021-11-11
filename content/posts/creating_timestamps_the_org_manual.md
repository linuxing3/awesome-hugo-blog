+++
title = "Creating Timestamps (The Org Manual)"
author = ["Xing Wenju"]
date = 2021-11-11T00:00:00-04:00
draft = false
+++

## <span class="org-todo todo ____">[学习]</span> 创建活动时间戳 {#创建活动时间戳}

`Org mode` 识别专门标识的时间戳

-   C-c . (org-time-stamp)

提示日期和时间。如果时间戳已经存在，进行修改。
连续输入2次，插入时间段。

Prompt for a date and insert a corresponding timestamp.  When point
is at an existing timestamp in the buffer, the command is used to
modify this timestamp instead of inserting a new one.  When this
command is used twice in succession, a time range is inserted.

如果包括前缀，这采用替代格式。默认时间可以以5分钟倍数的形式取整。
When called with a prefix argument, use the alternative format which
contains date and time.  The default time can be rounded to
multiples of 5 minutes.  See the option
org-time-stamp-rounding-minutes.

如果有2个前缀参数，插入活动时间戳，无任何提示。

With two prefix arguments, insert an active timestamp with the
current time without prompting.


## <span class="org-todo todo ____">[学习]</span> 插入非活动时间戳 {#插入非活动时间戳}

C-c ! (org-time-stamp-inactive)

Like C-c ., but insert an inactive timestamp that does
not cause an agenda entry.


## <span class="org-todo todo ____">[学习]</span> 修正化时间戳 {#修正化时间戳}

C-c C-c

如发现时间确实或错误，尝试插入或更正时间
Normalize timestamp, insert or fix day name if missing or wrong.


## 从日历获取日期 {#从日历获取日期}

C-c < (org-date-from-calendar)

Insert a timestamp corresponding to point date in the calendar.


## <span class="org-todo todo ____">[学习]</span> 访问日历中的日期 {#访问日历中的日期}

C-c > (org-goto-calendar)

Access the Emacs calendar for the current date.  If there is
a timestamp in the current line, go to the corresponding date
instead


## <span class="org-todo todo ____">[学习]</span> 打开Ａｇｅｎｄａ行事历 {#打开ａｇｅｎｄａ行事历}

C-c C-o (org-open-at-point)
Access the agenda for the date given by the timestamp or -range at
point (see Weekly/daily agenda).


## <span class="org-todo todo ____">[学习]</span> 加一天/减一天 {#加一天-减一天}

S-LEFT (org-timestamp-down-day)
S-RIGHT (org-timestamp-up-day)

Change date at point by one day.  These key bindings conflict with
shift-selection and related modes (see Conflicts).


## <span class="org-todo todo _BUG_">[BUG]</span> 加时间/减时间 {#加时间-减时间}

S-UP (org-timestamp-up)
S-DOWN (org-timestamp-down)

如光标在时间戳开始或者括号处，可以修改类型。在时间戳内部，修改所在点的
内容。每个点可以是年月日等时间单位。如果是时间段，修改开始时间将改变结束时间。

On the beginning or enclosing bracket of a timestamp, change its
type.  Within a timestamp, change the item under point.  Point can be
on a year, month, day, hour or minute.  When the timestamp contains a
time range like ‘15:30-16:30’, modifying the first time also shifts
the second, shifting the time block with constant length.  To change
the length, modify the second time.  Note that if point is in a
headline and not at a timestamp, these same keys modify the priority
of an item (see Priorities).  The key bindings also conflict with
shift-selection and related modes (see Conflicts)


## 验证时间段 {#验证时间段}

C-c C-y (org-evaluate-time-range)

Evaluate a time range by computing the difference between start and
end.  With a prefix argument, insert result after the time range (in
a table: into the following column).
