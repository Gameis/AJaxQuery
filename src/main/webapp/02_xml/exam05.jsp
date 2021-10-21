<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<style type="text/css">
* {
   padding: 0;
   margin: 0;
   color: #333;
}
ul {
   list-style: none;
}
#container {
   padding: 30px 20px;
}
h1 {
   font-size: large;
   border-left: 10px solid #7BAEB5;
   border-bottom: 1px solid #7BAEB5;
   padding: 10px;
   width: auto;
}
#comment_write {
   padding: 20px 15px;
   border-bottom: 1px solid #7BAEB5;
}
#comment_write label {
   display: inline-block;
   width: 80px;
   font-size: 14px;
   font-weight: bold;
   margin-bottom: 10px;
}
#comment_write input[type='text'], #comment_write textarea {
   border: 1px solid #ccc;
   vertical-align: middle;
   padding: 3px 10px;
   font-size: 12px;
   line-height: 150%;
}
#comment_write textarea {
   width: 380px;
   height: 90px
}
.comment_item {
   font-size: 13px;
   color: #333;
   padding: 15px;
   border-bottom: 1px dotted #ccc;
   line-height: 150%;
}
.comment_item .writer {
   color: #555;
   line-height: 200%;
}
.comment_item .writer input {
   vertical-align: middle;
}
.comment_item .writer .name {
   color: #222;
   font-weight: bold;
   font-size: 14px;
}
</style>
</head>
<body>
<div id="container">
   <h1>jQuery Comment</h1>
   <div id="comment_write">
      <form id="comment_form">
         <div>
            <label for="user_name">작성자</label>
            <input type="text" name="user_name" id="user_name" />
            <input type="submit" value="저장하기" />
         </div>
         <div>
            <label for="comment">덧글 내용</label>
            <textarea name="comment" id="comment"></textarea>
         </div>
      </form>
   </div>
   
   <ul id="comment_list">
   </ul>
</div>

<script type="text/javascript" src="http://code.jquery.com/jquery-3.6.0.min.js"></script>
<script type="text/javascript">
$(function() {
	$.get('../comment/comment_list.xml', {}, function(data) {
		
		$(data).find('item').each(function() {
			var num = $(this).find('num').text();
			var writer = $(this).find('writer').text();
			var content = $(this).find('content').text();
			var datetime = $(this).find('datetime').text();
			
			addItem(num, writer, content, datetime);
		});
	}).fail(function() {
		alert('덧글 목록을 불러오는데 실패하였습니다. 잠시 후에 다시 시도해주세요');
	});
	
	$(document).on('click', '.delete_btn', function() {
		//alert($(this).prop('tagName'));
		if(confirm('선택하신 항목을 삭제하시겠습니까?')) {
			var num = $(this).parents('li').attr('data-num');
			//alert(num);
			var target = $(this).parents('.comment_item');
			var url = "../comment/comment_delete.jsp";
			
			$.post(url, {'num' : num}, function(data) {
				var result = eval($(data).find('result').text());
				var message = $(data).find('message').text();
				
				if(result) {
					target.remove();
				}
			}).fail(function() {
				alert("실패");
			});
		}
	});
	
	$('#comment_form').submit(function(){
		if(!$('#user_name').val()){
			alert('이름을 입력하세요.');
			$('#user_name').focus();
		}
	      
		if(!$('#comment').val()){
			alert('내용을 입력하세요.');
			$('#comment').focus();
		}
		
		var url = '../comment/comment_write.jsp';
		$.post(url, {'user_name': $('#user_name').val(),
					'comment' : $('#comment').val()}, function(data){
						var result = eval($(data).find($('result')).text());
						
						var num = $(data).find('num').text();
						var writer = $(data).find('writer').text();
						var content = $(data).find('content').text();
						var datetime = $(data).find('datetime').text();
						
						addItem(num, writer, content, datetime);
						
					}).fail(function() {
						alert("덧글 작성하는데 실패하였습니다. 잠시 후에 다시 시도해 주세요.");
					});
		
		return false;
	})
});

function addItem(num, writer, content, datetime) {
	var new_li = $('<li>');
	new_li.attr('data-num', num);
	new_li.addClass('comment_item');
	
	var writer_p = $('<p>');
	writer_p.addClass('writer');
	
	var name_span = $('<span>');
	name_span.addClass('name');
	name_span.html(writer + '님');
	
	var date_span = $('<span>');
	date_span.html('/' + datetime + '');
	
	var del_input = $('<input>');
	del_input.attr({
		'type' : 'button',
		'value' : '삭제하기'
	});
	del_input.addClass('delete_btn');
	
	var content_p = $('<p>');
	content_p.html(content);
	
	writer_p.append(name_span).append(date_span).append(del_input);
	
	new_li.append(writer_p).append(content_p);
	
	$('#comment_list').append(new_li);
	
}
</script>
</body>
</html>