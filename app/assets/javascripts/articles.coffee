$(document).on "turbolinks:load", ->

    Prism.highlightAll()

    $("a[data-comment-id]").click (e) ->
        e.preventDefault()
        comment_id = $(this).data("comment-id")
        comment_user = $(this).data("comment-user")
        if $('#comment_comment_id').val()
            $('#comment_comment_id').val null
            $('#comment_content').attr 'placeholder', '留下您的高见'
        else
            $('#comment_comment_id').val comment_id
            $('#comment_content').attr 'placeholder', '回复' + comment_user + ': (再次点击上面的回复按钮可以取消回复)'

    editor = new Simditor(
        textarea: $('#article_content')
        toolbar: [ 'bold', 'italic', 'underline', 'strikethrough', 'color', '|',
            'code', 'blockquote', 'link', 'image', 'ol', 'ul', 'table', '|',
            'indent','outdent','alignment']
        pasteImage: true,
        fileKey: 'file',
        upload: {
            url: '/images',
            params: {"content":"image"},
            connectionCount: 3,
            leaveConfirm: '有图片正在上传，确定要离开?'
    })
