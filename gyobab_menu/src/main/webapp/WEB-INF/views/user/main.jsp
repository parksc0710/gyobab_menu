<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://www.springframework.org/security/tags" prefix="security" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>

<div class="content">
	<div class="card-header">
        <h3><b>내 정보</b></h3>
   </div>
   
   <div class="card-body">

          <div class="form-group">
              <label for="exampleInputEmail1">E-mail</label>
              <input type="text" class="form-control" id="memberEmail" placeholder="${nowUser.member_email }" readonly>
              <small id="emailHelp" class="form-text text-muted">이메일 주소는 변경할 수 없습니다. </small>
          </div>
          <div class="form-group beforeSpan">
              <label for="exampleInputEmail1"><b>닉네임</b></label>
              <input type="text" class="form-control" id="memberName" maxlength=10 value="${nowUser.member_name }" readonly>
              <small id="numberlHelp" class="form-text text-muted"></small>
              <a href="javascript:setNameInput();" class="btn btn-primary btn-sm btn-block" style="width:150px" id="nickChangeBtn"><i class="far fa-edit"></i>닉네임 변경하기</a>
          </div>
          <div class="form-group beforeSpan">
              <label for="exampleInputEmail1"><b>교회 출입 바코드</b></label>
              <c:if test="${nowUser.member_pass eq null }">
             	 <form id="updateForm1" name="updateForm1" method="post">
					<input type="file" id="imageUploadFile" name="imageUploadFile" />
					<a href="javascript:void(0);" class="button" onclick="jsFileUpload('pass','updateForm1');"><span class="new">등록</span></a>	
				 </form>
              </c:if>
              <c:if test="${nowUser.member_pass != null }">
              </c:if>
              <small id="numberlHelp" class="form-text text-muted"></small>
          </div>
          <br>
          <button type="submit" class="btn btn-primary" id="submitBtn">수정하기</button>

   </div>
   
   <script>
   
   		var memberId = "${nowUser.member_id }";
   
		var isNickChecked = false;
	
		var oldName = "${nowUser.member_name }";
		
   		function setNameInput() {
   			$("#memberName").attr("readonly", false);
   			alert("변경할 닉네임을 입력하여주세요!");
   			$("#nickChangeBtn").hide();
   		}
   		
   		//닉네임 input blur 이벤트
   		$("#memberName").blur(function() {
   			
   			if($("#memberName").attr("readonly")) {
   				return false;
   			}
   			
   		    var nickName = $("#memberName").val();
   		    
   		    if(nickName == "" || nickName == null) {
   		    	setMsgSpan("memberName", 0, "닉네임을 올바르게 입력해주세요."); 
   		    	isNickChecked = false;
   		        return false;
   		    }
   		    
   		    // 닉네임 정규식 체크
   		    var regExp = /^[가-힣a-zA-Z0-9\s]+$/
   		       
   		    if(!nickName.match(regExp)) {
   		    	setMsgSpan("memberName", 0, "닉네임은 한글, 숫자, 영문자로 구성되어야 합니다."); 
   		    	isNickChecked = false;
   		        return false;
   		    }
   		   	if(nickName != oldName) {
	   		    $.ajax({
	   		       type: "post", 
	   		       dataType: "text", 
	   		       contentType: "application/x-www-form-urlencoded;charset=utf-8",
	   		       url: "${pageContext.request.contextPath}/checkNick.do",
	   		       data : {nickname : nickName},
	   		       success: function(rtn) {
	   		    	  
	   		    	   //console.log(rtn);
	   		    	   
	   		          if(rtn == "" || rtn == null) {
	   		        	  setMsgSpan("memberName", 0, "닉네임 중복체크에 실패했습니다. 관리자에게 문의하세요."); 
	   		              isNickChecked = false;
	   		              return false;
	   		          }
	   		          
	   		          if (rtn == "success"){
	   		        	  setMsgSpan("memberName", 1, "사용 가능한 닉네임입니다.");
	   		        	  isNickChecked = true;
	   		          }else{
	   		        	  setMsgSpan("memberName", 0, "이미 사용중인 닉네임입니다."); 
	   		        	  isNickChecked = false;
	   		          } 
	   		       },
	   		       error:function(request,status,error){
	   		           alert("code:"+request.status+"\n"+"message:"+request.responseText+"\n"+"error:"+error);
	   		       }
	   		    });
   		   	} else {
   		  	 	setMsgSpan("memberName", 1, "기존에 사용하던 닉네임입니다.");
	        	isNickChecked = true;
   		   	}
   		    
   		});
   		
   		// 인풋 값에 대한 메시지 출력 기능 function
   		function setMsgSpan(id, type, msg) {
   			var parentElement = $("#" + id).closest(".beforeSpan");
   			
   			// type이 -1 이면 p 삭제
   			if(type == -1) {
   				parentElement.children("p.addtxt_area").remove();
   				return false;
   			}
   			
   			// type이 1이면 긍정 메시지 설정, 1이 아니면 부정 메시지 설정
   			var tmpHtml = (type == 1) ? "<p class='addtxt_area'><span style='color:#57932f'>" + msg + "</span></p>" : "<p class='addtxt_area'><span class='pwInVaild' style='color:#ff3600'>" + msg + "</span></p>";
   			
   			// id 값을 받아와 해당하는 엘리먼트의 마지막 p 태그 삭제
   			parentElement.children("p.addtxt_area").remove();

   			// tmpHtml 추가
   			parentElement.append(tmpHtml);
   			
   		}
   		
   		$("#submitBtn").click(function() {
   			if(!isNickChecked) {
   				alert("닉네임을 확인하여주세요!");
   				return;
   			} else {
   				
   				var nickName = $("#memberName").val();
   				
   				$.ajax({
   				       type: "post", 
   				       dataType: "text", 
   				       contentType: "application/x-www-form-urlencoded;charset=utf-8",
   				       url: "${pageContext.request.contextPath}/user/update.do",
   				       data : {memberId : memberId, nickname : nickName},
   				       success: function(rtn) {
   				    	  alert("정보 수정이 완료되었습니다.");
   			        	  window.location.href = '${pageContext.request.contextPath}/main.do';
   				       },
   				       error:function(request,status,error){
   				           alert("회원가입에 실패했습니다. 관리자에게 문의하세요.");
   				       }
   				    });
   			}
   			
   		});
   		
   		function jsFileUpload(gubun, frmId) {
   			var size = $("#"+frmId)["0"]["0"].files["0"].size;
   			//alert(size);
   			if(size > 10*1024*1024)	{
   				alert("파일 업로드 용량 초과(10MB)");
   				return false;
   			}
   			
   			$.imageFileUpload({
   				 url: '${pageContext.request.contextPath}/fupload.cgn'
   				,formId: frmId //'updateForm'
   				,success: function(fileName) {
   					//alert(fileName);

   					if(gubun == "pass")	{
   						$("#thumbfile").val(fileName);
   						//$("#"+frmId).html("<a href=\"#;\" class=\"button\" onclick=\"jsFileRemove(\'"+gubun+"\',\'"+frmId+"\');\"><img src=\""+fileName.replace("/data/www","http:/")+"\"/> <span class=\"delete\">삭제</span></a>");
   						$("#"+frmId).html("<img src=\""+fileName+"\"/> <a href=\"#;\" class=\"button\" onclick=\"jsFileRemove(\'"+gubun+"\',\'"+frmId+"\');\"><span class=\"delete\">삭제</span></a>");
   					} else {
   						$("#attachfile").val(fileName);
   						//$("#"+frmId).html("<a href=\"#;\" class=\"button\" onclick=\"jsFileRemove(\'"+gubun+"\',\'"+frmId+"\');\"> * "+fileName.replace("/data/www","http:/")+" <span class=\"delete\">삭제</span></a>");
   						$("#"+frmId).html(" * "+fileName+" <a href=\"#;\" class=\"button\" onclick=\"jsFileRemove(\'"+gubun+"\',\'"+frmId+"\');\"><span class=\"delete\">삭제</span></a>");
   					}
   					
   				}
   				,error: function(e) {
   					alert(JSON.stringify(e));
   				}
   			});
   		};
   		
   		function jsFileRemove(gubun, frmId) 	{
   			var filenameTxt = $("#"+gubun+"file").val();
   				
   			$.ajax({ 
   				url: "${pageContext.request.contextPath}/fremove.cgn" , 
   				type: "POST",
   				data: {filename : filenameTxt},
   				success: function(data) {
   					//alert(data);
   					if(data){
   						//파일 삭제
   						$("#"+gubun+"file").val("");
   						$("#"+frmId).html("<input type=\"file\" id=\"imageUploadFile\" name=\"imageUploadFile\" /><a href=\"#;\" class=\"button\" onclick=\"jsFileUpload(\'"+gubun+"\',\'"+frmId+"\');\"> <span class=\"new\">추가</span></a>");
   					}
   					else
   						alert("파일삭제에 실패하였습니다.");
   				}
   				,error: function(e) {
   					alert(JSON.stringify(e));
   				}
   			});
   		}
   		
   		$.imageFileUpload = function(args) {
   			var targetFormObj = $('#' + args.formId);
   			var targetForm = targetFormObj[0];
   			var iframeName = '__imageUploadIframe';
   			targetFormObj.attr('enctype', 'multipart/form-data');
   			targetForm.method = 'POST';
   			targetForm.target = iframeName;
   			targetForm.action = args.url;
   			$('body').append('<iframe id="' + iframeName + '" name="' + iframeName + '" style="display:none;" src=""></iframe>');
   			$('iframe#'+iframeName).bind('load', function (){
   				var hiddenIframe = $('#__imageUploadIframe');
   				var err;
   				var fileName;
   				try {
   					fileName = eval(hiddenIframe.contents().find('body').text())[0];
   				} catch (e) {
   					err = e;
   				}
   				hiddenIframe.remove();
   				targetFormObj.attr('enctype', 'application/x-www-form-urlencoded');
   				if(fileName != null && fileName != '')
   					args.success(fileName);
   				else
   					args.error(err);
   			});
   			targetForm.submit();
   		};	
   </script>
   
</div>