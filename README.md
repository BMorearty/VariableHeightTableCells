# An attempt to make variable height table cells work in iOS 7.

I want variable-height table cells in iOS 7.

But no matter how hard I try, and how many videos I watch, and how 
many StackOverflow answers I read, I can't make them work perfectly.

The best tutorial I found was [this video by Paul Solt](http://youtu.be/6KImie4ZMwk).
I followed these instructions (including the instruction by commenter
Avnish Gaur to set preferredMaxLayoutWidth). It works in some cases,
but not all.

See tableView:heightForRowAtIndexPath: in MasterViewController.swift for details.

I'm ready to give up and used fixed-height cells.

# UPDATE: Problem solved.

[My brother](https://github.com/mmorearty) figured out that I wasn't taking
into account the width of the disclosure arrows on the table.
If I either subtract the disclosure arrow width from the preferredMaxLayoutWidth,
or remove the arrows from the UI, it works. I chose the latter.

## Before

![](With-disclosure-arrows.png)

## After

![](Without-disclosure-arrows.png)
