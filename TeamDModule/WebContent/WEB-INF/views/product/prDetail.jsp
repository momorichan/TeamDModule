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
      .cart{background-color:black;border:1px solid black;} /* �Ӽ� ǥ��� */
      .rightnow{background-color:red;border:1px solid red;}
      #qty{margin:-10px;border:0px;font-size:0.7rem;}   
      .plus, .minus{font-size:1.1rem;}   
   </style>
   
   
   <%-- ${lcategory} : ��з� ī�װ� --%>
   <%-- ${lcategory.scategories} : �Һз� ī�װ� --%>
   <%-- ${scategories.products} : ��ǰ���� --%>
   
   
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
      var price = ${price};
      $(document).ready(function(){
         var popoverTriggerList = [].slice.call(document.querySelectorAll('[data-bs-toggle="popover"]'))
         var popoverList = popoverTriggerList.map(function (popoverTriggerEl) {
             return new bootstrap.Popover(popoverTriggerEl);
         });
         
         
         
         $('#qty').innerWidth($('.minus').innerWidth() - 3); /* ��Ÿ�� ���� */
         $('#totalprice').text('0') ; /* ���� ���۽� �ݾ��� 0���� ���� */
         
         /* attr() �Լ��� �Ӽ�(attribute)�� �аų� ���� ���� �Լ� */
         $('.small_image').click(function(){
            $('.active_image').attr('src', $(this).attr('src')) ;
         }); /* �����̹��� Ŭ�������� ū �̹��� â���� �Ѿ  */
         
         $('.plus').click(function(){  /* ����ڰ� + ��ư�� Ŭ���� */
            event.preventDefault(); // #(��ġ�� �����ϴ� url) �߰��� ���� , ���� ��ħ�� ����
            var qty = $('#qty').val();
           
            var newQty = Number(qty) + 1 ;
            if(qty == ''){
               $('#qty').val('1');
            }else{
               $('#qty').val(newQty) ;
            }
            var amount = newQty*price ;
            $('#totalprice').text(amount.toLocaleString()) ;
         });
          
         $('.minus').click(function(){ /* ����ڰ� - ��ư�� Ŭ���� */
            event.preventDefault(); 
            var qty = $('#qty').val();
            if(qty == '0'){
               alert('�ּ� 1�� �̻� �����ϼž� �մϴ�.');
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
         
         $('#qty').blur(function(){ /* ���� �Է¶��� ��Ŀ���� ���� �� */
            var qty = $('#qty').val();
            
            if(qty == '' || isNaN(qty) == true){
               alert('1�� �̻� ��ƾ��մϴ�.' );
               $('#qty').val('0');
               $('#qty').focus();
               return ;
            }
            
            if(isNaN(qty) == false){
               var newQty = Number(qty) ;
               if(newQty < 0 || newQty > maxPurchaseSize){
                  alert('1�� �̻� ��ƾ��մϴ�.');
                  $('#qty').val('0');
                  $('#qty').focus();
                  return ;
               }
            }
         });
         
         $('.cart').click(function(){ /* ��ٱ��� Ŭ�� */
            var qty = $('#qty').val();
            if(qty < 1){
               alert('�ּ� 1�� �̻� īƮ�� ���� �� �ֽ��ϴ�.' );
               event.preventDefault(); 
               return ;
            }
         });
         
         $('.rightnow').click(function(){ /* ��� ���� Ŭ�� */
            var qty = $('#qty').val();
            if(qty < 1 ){
               alert('��� ���Ŵ� �ּ� 1�� �̻� �����մϴ�.' );
               event.preventDefault(); 
               return ;
            }
         });
         
         
      });
      
   </script>   
</head>
<body>
   <div class="container">
      <h2>��ǰ �󼼺���</h2>
      
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
                        �հ� : <span id="totalprice"></span>��
                     </p>
                     <form action="addCart" method="post">                     
                     <ul class="pagination">
                        <li class="page-item"><a class="page-link minus" href="#"> - </a></li>
                        <li class="page-item">
                           <a class="page-link" href="">
                              <input type="hidden" name="command" value="maInsert">
                              <input type="hidden" name="pnum" value="${pnum}">
                              <input type="hidden" name="stock" value="${stock}">
                              
                              <input type="text" name="qty" id="qty" value="0"
                              data-bs-trigger="hover" data-bs-toggle="popover" 
                              title="���� ���� �˸�" 
                              data-bs-content="���� īƮ�� ǰ���� �̹� �����ϸ� ������ �����մϴ�.">
                           </a>
                        </li>
                        <li class="page-item"><a class="page-link plus" href="#"> + </a></li>
                     </ul>
                     <div class="btn-group">
                        <button type="submit" class="btn btn-primary cart">��ٱ���</button>
                        <button type="button" class="btn btn-primary rightnow">�ٷ� ����</button>                                	
                     </div>
                   
                       <div  style="margin-top: 50px;">
									<button type="button" class="btn btn-secondary" onclick="history.back();">�ڷΰ���</button>

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