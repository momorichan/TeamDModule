<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>

<%@ include file = "../temp/header.jsp"%>

<article>
   <div class="container">
      <h2>상품 등록</h2>
      <p>관리자가 구매할 상품을 등록하는 페이지입니다.</p>
      <form action="" method="post" enctype="multipart/form-data">
         <div class="input-group">
            <span class="input-group-text">상품 이름</span>
            <input class="form-control" type="text" id="name" name="name">            
         </div>
         <div class="input-group">
            <span class="input-group-text">이미지01</span>
            <input class="form-control" type="file" id="image01" name="image01">            
         </div>
         <div class="input-group">
            <span class="input-group-text">이미지02</span>
            <input class="form-control" type="file" id="image02" name="image02">            
         </div>
         <div class="input-group">
            <span class="input-group-text">이미지03</span>
            <input class="form-control" type="file" id="image03" name="image03">            
         </div>
         <div class="input-group">
            <span class="input-group-text">재고 수량</span>
            <input class="form-control" type="number" id="stock" name="stock">            
         </div>
         <div class="input-group">
            <span class="input-group-text">단가</span>
            <input class="form-control" type="number" id="price" name="price">            
         </div>
         <div class="input-group">
            <span class="input-group-text">대분류카테고리</span>
            <select id="lcategory" name="lcategory" class="form-select">
               <c:forEach var="category" items="${lclist}"> 
                  <option value="${category.lcnum}">${category.lcname}</option>
               </c:forEach>
            </select>            
         </div>
         <div class="input-group">
            <span class="input-group-text">소분류카테고리</span>
            <select id="scategory" name="scategory" class="form-select">
               <c:forEach var="category" items="${sclist}"> 
                  <option value="${category.scnum}">${category.scname}</option>
               </c:forEach>
            </select>            
         </div>
         <div class="input-group">
            <span class="input-group-text">상품 상세 설명</span>
            <input class="form-control" type="text" id="contents" name="contents">            
         </div>         
         <div id="buttonset" class="input-group">
            <button type="submit" class="btn btn-primary btn-lg"
               onclick="return validCheck();">등록
            </button>
            &nbsp;&nbsp;&nbsp;
            <button type="reset" class="btn btn-secondary btn-lg">초기화</button>
         </div>
      </form>
   </div>
</article>
<script>
$.ajax({ // ajax 기본형태
	url: "/sclist",

});	



	window.onload = function() {
		let number = 1;
		document.querySelector("#load1").onclick = function(e) {
			e.preventDefault();
			let param = null;
			sendRequest("boardJsonList", param, res, "get");
		}
		document.querySelector("#sendAjax").onclick = function(e) {
			e.preventDefault();
			//동적으로 전달할 객체
			/*
			num:1,
			title:"오늘은 왠지 ㅎㅎㅎㅎㅎ0",
			writer:"김길동",
			content:"내용1",
			reip:"192.168.0.113",
			bdate:"2023-06-14"
			 */
			const data = {}
			data.num = number;
			data.title = document.getElementById("title").value;
			data.content = document.getElementById("content").value;
			data.writer = document.getElementById("writer").value;
			data.reip = document.getElementById("reip").value;
			data.bdate = "2023-06-14";
			let param = JSON.stringify(data); //json으로 변환
			let type = "json";
			//alert(data.bdate);
			sendRequest("RequestParamDemo", param, res2, "post", type);
			number++;
		}
		//callback
		function res() {
			if(xhr.readyState === 4){
				if(xhr.status === 200){
					$('#target').empty();
					let res = xhr.responseText;
					console.log("res =>"+ res);
					let data = JSON.parse(xhr.responseText);
					dataListLoad(data);
				}
			}
		}
		
		function dataListLoad(data) {
			data.forEach(item => {
		        var tr = $('<tr>');
		        
		        
		        
		        tr.append($('<td>').text(item.num));
		        tr.append($('<td>').text(item.title));
		        tr.append($('<td>').text(item.writer));
		        tr.append($('<td>').text(item.reip));
		        tr.append($('<td>').text(item.bdate));

		        $('#target').append(tr);
		    });
		}
		
		function res2() {
			if(xhr.readyState === 4){
				if(xhr.status === 200){
					let res = xhr.responseText;
					console.log("res2 =>"+ res);
				}
			}
		}
	}
</script>
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>