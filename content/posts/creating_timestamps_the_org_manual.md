+++
title = "Creating Timestamps (The Org Manual)"
author = ["Xing Wenju"]
date = 2021-11-11T00:00:00-04:00
draft = false
+++

## <span class="org-todo todo ____">[ѧϰ]</span> �����ʱ��� {#�����ʱ���}

`Org mode` ʶ��ר�ű�ʶ��ʱ���

-   C-c . (org-time-stamp)

��ʾ���ں�ʱ�䡣���ʱ����Ѿ����ڣ������޸ġ�
��������2�Σ�����ʱ��Ρ�

Prompt for a date and insert a corresponding timestamp.  When point
is at an existing timestamp in the buffer, the command is used to
modify this timestamp instead of inserting a new one.  When this
command is used twice in succession, a time range is inserted.

�������ǰ׺������������ʽ��Ĭ��ʱ�������5���ӱ�������ʽȡ����
When called with a prefix argument, use the alternative format which
contains date and time.  The default time can be rounded to
multiples of 5 minutes.  See the option
org-time-stamp-rounding-minutes.

�����2��ǰ׺����������ʱ��������κ���ʾ��

With two prefix arguments, insert an active timestamp with the
current time without prompting.


## <span class="org-todo todo ____">[ѧϰ]</span> ����ǻʱ��� {#����ǻʱ���}

C-c ! (org-time-stamp-inactive)

Like C-c ., but insert an inactive timestamp that does
not cause an agenda entry.


## <span class="org-todo todo ____">[ѧϰ]</span> ������ʱ��� {#������ʱ���}

C-c C-c

�緢��ʱ��ȷʵ����󣬳��Բ�������ʱ��
Normalize timestamp, insert or fix day name if missing or wrong.


## ��������ȡ���� {#��������ȡ����}

C-c < (org-date-from-calendar)

Insert a timestamp corresponding to point date in the calendar.


## <span class="org-todo todo ____">[ѧϰ]</span> ���������е����� {#���������е�����}

C-c > (org-goto-calendar)

Access the Emacs calendar for the current date.  If there is
a timestamp in the current line, go to the corresponding date
instead


## <span class="org-todo todo ____">[ѧϰ]</span> �򿪣������������� {#�򿪣������������}

C-c C-o (org-open-at-point)
Access the agenda for the date given by the timestamp or -range at
point (see Weekly/daily agenda).


## <span class="org-todo todo ____">[ѧϰ]</span> ��һ��/��һ�� {#��һ��-��һ��}

S-LEFT (org-timestamp-down-day)
S-RIGHT (org-timestamp-up-day)

Change date at point by one day.  These key bindings conflict with
shift-selection and related modes (see Conflicts).


## <span class="org-todo todo _BUG_">[BUG]</span> ��ʱ��/��ʱ�� {#��ʱ��-��ʱ��}

S-UP (org-timestamp-up)
S-DOWN (org-timestamp-down)

������ʱ�����ʼ�������Ŵ��������޸����͡���ʱ����ڲ����޸����ڵ��
���ݡ�ÿ��������������յ�ʱ�䵥λ�������ʱ��Σ��޸Ŀ�ʼʱ�佫�ı����ʱ�䡣

On the beginning or enclosing bracket of a timestamp, change its
type.  Within a timestamp, change the item under point.  Point can be
on a year, month, day, hour or minute.  When the timestamp contains a
time range like ��15:30-16:30��, modifying the first time also shifts
the second, shifting the time block with constant length.  To change
the length, modify the second time.  Note that if point is in a
headline and not at a timestamp, these same keys modify the priority
of an item (see Priorities).  The key bindings also conflict with
shift-selection and related modes (see Conflicts)


## ��֤ʱ��� {#��֤ʱ���}

C-c C-y (org-evaluate-time-range)

Evaluate a time range by computing the difference between start and
end.  With a prefix argument, insert result after the time range (in
a table: into the following column).
