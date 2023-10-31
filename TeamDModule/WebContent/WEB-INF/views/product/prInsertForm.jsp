<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    

    
<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<title>Insert title here</title>
  	<style type="text/css">
  		/* box model에 대한 공부가 필요합니다. */
  		.container{margin-top: 10px;}
  		.input-group{margin: 7px;}
  		.input-group-text{
  			display: block;
  			margin-left: auto;
  			margin-right: auto;
  		}
  		#buttonset{margin-top: 15px;}
  		.radio_gender, .checkbox_hobby{font-size: 1.1rem;} /* 주위 글꼴의 1.1배 */
  		#productPnum{display: none;visibility: hidden;} /* 상품 번호는 안보이게 지정*/
  	</style>

</head>
<body>
	<div class="container">
		<h2>상품 등록</h2>
		<p>관리자가 구매할 상품을 등록하는 페이지입니다.</p>
		<form action="" method="post" enctype="multipart/form-data">
			<input type="hidden" name="command" value="prInsert">
			<div id="productPnum" class="input-group">
				<span class="input-group-text">상품 번호</span>
				<input class="form-control" type="number" id="pnum" name="pnum">				
			</div>
			<div class="input-group">
				<span class="input-group-text">상품 이름</span>
				<input class="form-control" type="text" id="name" name="name">				
			</div>
			<div class="input-group">
				<span class="input-group-text">제조 회사</span>
				<input class="form-control" type="text" id="company" name="company">				
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
				<span class="input-group-text">카테고리</span>
				<select id="category" name="category" class="form-select">
					<c:forEach var="category" items="${requestScope.categories}"> 
						<option value="${category.engname}">${category.korname}</option>
					</c:forEach>
				</select>				
			</div>
			<div class="input-group">
				<span class="input-group-text">상품 상세 설명</span>
				<input class="form-control" type="text" id="contents" name="contents">				
			</div>			
			<div class="input-group">
				<span class="input-group-text">적립 포인트</span>
				<input class="form-control" type="number" id="point" name="point">				
			</div>			
			<div class="input-group">
				<span class="input-group-text">입고 일자</span>
				<input class="form-control" type="datetime" id="inputdate" name="inputdate">				
			</div>
			<div id="buttonset" class="input-group">
				<button type="submit" class="btn btn-primary btn-lg"
					onclick="return validCheck();"> 
					등록
				</button>
				&nbsp;&nbsp;&nbsp;
				<button type="reset" class="btn btn-secondary btn-lg">초기화</button>
			</div>
		</form>
	</div>
</body>
</html>