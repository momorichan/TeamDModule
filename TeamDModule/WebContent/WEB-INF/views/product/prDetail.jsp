<%@ page language="java" contentType="text/html; charset=EUC-KR" pageEncoding="EUC-KR"%>
<%@include file="../temp/header.jsp"%>
<!DOCTYPE html>
<html>
<head>
   <title>Insert title here</title>
   <style type="text/css">
      .container{margin-top: 5px;}
      .card{margin-left:auto;margin-right:auto;}
      .leftside{margin-left:0px;}
      .card_borderless{border:0px;}
      
      .small_image{width:100px;height:100px;margin:2px;border-radius:5px;}
      #totalprice{color:red;font-size: 20px;font-weight:bolder;}
      .cart{background-color:black;border:1px solid black;} /* 속성 표기법 */
      .rightnow{background-color:red;border:1px solid red;}
      #qty{margin:-10px;border:0px;font-size:0.7rem;}   
      .plus, .minus{font-size:1.1rem;}   
   </style>
   <c:set var="lcname" value="${lcategory.lcname }"/>
   <c:forEach var="scategories" items="${lcategory.scategories }">
      <c:set var="scname" value="${scategories.scname }"/>
   <c:forEach var="products" items="${scategories.products}">
      <c:set var="pnum" value="${products.pnum }"/>   
      <c:set var="pname" value="${products.pname }"/>   
      <c:set var="price" value="${products.price }"/>   
      <c:set var="stock" value="${products.stock }"/>
      <c:set var="pdetail" value="${products.pdetail }"/>
      <c:set var="image" value="${products.image }"/>
      <c:set var="image2" value="${products.image2 }"/>
      <c:set var="image3" value="${products.image3 }"/>
   </c:forEach>
   </c:forEach>
   
   
   
   <script>
      /* const 키워드는 읽기 전용(자바의 final과 동일 개념)*/
      // const maxPurchaseSize = 5 ; /* 최대 구매 가능 개수 */
      
      /*var price = 10000*/;  /* 단가 */
      var price = ${price};
      $(document).ready(function(){
         var popoverTriggerList = [].slice.call(document.querySelectorAll('[data-bs-toggle="popover"]'))
         var popoverList = popoverTriggerList.map(function (popoverTriggerEl) {
             return new bootstrap.Popover(popoverTriggerEl);
         });
         
         
         
         $('#qty').innerWidth($('.minus').innerWidth() - 3);
         $('#totalprice').text('0') ; /* 최초 시작시 금액을 0으로 설정 */
         
         /* attr() 함수는 속성(attribute)을 읽거나 쓰기 위한 함수 */
         $('.small_image').click(function(){
            $('.active_image').attr('src', $(this).attr('src')) ;
         });
         
         $('.plus').click(function(){  /* 사용자가 + 버튼을 클릭함 */
            event.preventDefault(); 
            var qty = $('#qty').val();
            /* if(qty == maxPurchaseSize){
               alert('최대 ' + maxPurchaseSize + '개 까지만 주문이 가능합니다.');
               return ; /* 더이상 진행하지 않도록 할께요. 
            } */
            /* Number 객체는 Integer.parseInt()와 동일한 효과 */
            var newQty = Number(qty) + 1 ;
            if(qty == ''){
               $('#qty').val('1');
            }else{
               $('#qty').val(newQty) ;
            }
            var amount = newQty*price ;
            $('#totalprice').text(amount.toLocaleString()) ;
         });
          
         $('.minus').click(function(){ /* 사용자가 - 버튼을 클릭함 */
            event.preventDefault(); 
            var qty = $('#qty').val();
            if(qty == '0'){
               alert('최소 1개 이상 구매하셔야 합니다.');
               return ;
            }
            
            var newQty = Number(qty) - 1 ;
            if(qty == ''){
               $('#qty').val('');
               $('#totalprice').text('0') ;
            }else{
               $('#qty').val(newQty) ;
               
               var amount = newQty*price ;
               $('#totalprice').text(amount.toLocaleString()) ;
            }            
         });
         
         $('#qty').blur(function(){ /* 수량 입력란이 포커스를 잃을 때 */
            var qty = $('#qty').val();
         
            if(qty == '' || isNaN(qty) == true){
               alert('1개 이상 담아야합니다.' );
               $('#qty').val('0');
               $('#qty').focus();
               return ;
            }
            
            if(isNaN(qty) == false){
               var newQty = Number(qty) ;
               if(newQty < 0 || newQty > maxPurchaseSize){
                  alert('1개 이상 담아야합니다.');
                  $('#qty').val('0');
                  $('#qty').focus();
                  return ;
               }
            }
         });
         
         $('.cart').click(function(){ /* 장바구니 클릭 */
            var qty = $('#qty').val();
            if(qty < 1){
               alert('최소 1개 이상 카트에 담을 수 있습니다.' );
               event.preventDefault(); 
               return ;
            }
         });
         
         $('.rightnow').click(function(){ /* 즉시 구매 클릭 */
            var qty = $('#qty').val();
            if(qty < 1 ){
               alert('즉시 구매는 최소 1개 이상 가능합니다.' );
               event.preventDefault(); 
               return ;
            }
         });
         
         
      });
      
   </script>   
</head>
<body>
   <div class="container">
      <h2>상품 상세보기</h2>
      
      <p>${lcname} > ${scname} </p>      
      <table class="table table-borderless">
         <thead>
         </thead>
         <tbody>
         
            <tr>
               <td class="col-lg-5">                  
                  <div class="card" style="width: 30rem;">
                     <img alt="${pname}" src="${rPath}/imgfile/${image}" 
                        class="car-img-top active_image">
                  </div>
               </td>
               
               <td class="col-lg-1">
                  <img alt="${pname}" src="${rPath}/imgfile/${image}" 
                        class="car-img-top small_image rounded" >
                  
                  <c:if test="${not empty image2}">
                     <img alt="${pname}" src="${rPath}/imgfile/${image2}" 
                        class="car-img-top small_image rounded" >
                  </c:if>      
                  
                  <c:if test="${not empty image3}">
                     <img alt="${pname}" src="${rPath}/imgfile/${image3}" 
                        class="car-img-top small_image rounded" >
                  </c:if>
               </td>
               
               <td class="col-lg-6">
                  <div class="card leftside card_borderless" style="width: 18rem;">
                     <h5 class="card-title">${pname}</h5>
                     <p class="card-text">${pdetail}</p>
                     <p class="card-text">
                        합계 : <span id="totalprice">10,000</span>원
                     </p>
                     <form action="addCart" method="post">                     
                     <ul class="pagination">
                        <li class="page-item"><a class="page-link minus" href="#"> - </a></li>
                        <li class="page-item">
                           <a class="page-link" href="#">
                              <input type="hidden" name="command" value="maInsert">
                              <input type="hidden" name="pnum" value="${pnum}">
                              <input type="hidden" name="stock" value="${stock}">
                              
                              <input type="text" name="qty" id="qty" value="0"
                              data-bs-trigger="hover" data-bs-toggle="popover" 
                              title="수량 누적 알림" 
                              data-bs-content="기존 카트에 품목이 이미 존재하면 수량을 누적합니다.">
                           </a>
                        </li>
                        <li class="page-item"><a class="page-link plus" href="#"> + </a></li>
                     </ul>
                     <div class="btn-group">
                        <button type="submit" class="btn btn-primary cart">장바구니</button>
                        <button type="button" class="btn btn-primary rightnow">바로 구매</button>                        
                     </div>
                     </form>
                  </div>
               </td>
            </tr>
         </tbody>
      </table>      
   
   </div>    
</body>
</html>