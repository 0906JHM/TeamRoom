//input으로 바꾸기 
		function inputCng(obj, type, name, value) {
			var inputBox = "<input type='"+type+"' name='"+name+"' id='"+name+"' value='"+value+"'>";
			obj.html(inputBox);
		} //inputCng	
    
		// 팝업 옵션
		const popupOpt = "top=60,left=140,width=777,height=677";
		const popupOpt2 = "top=60,left=140,width=977,height=677";
	
		//검색 팝업
	  	function openWindow(search, inputId) {
	   	 	var url = "${pageContext.request.contextPath}/workorder/search?type=" + search + "&input=" + inputId;
	    	var popup = window.open(url, "", popupOpt);
	    } //openWindow()
	    
	    //검색 팝업2
		function openWindow2(search, inputId) {
			var url = "${pageContext.request.contextPath}/requirement/whsearch?type=" + search + "&input=" + inputId;
			var popup = window.open(url, "", popupOpt2);
		} //openWindow()
		
		//추가 시 품번 검색 
        function serchProd(inputId){
        	openWindow("prod",inputId);
        }
		
      	//추가 시 원자재 검색 
        function serchRaw(inputId){
        	openWindow2("raw",inputId);
        }
      	
        function submitForm() {
      	  var isValid = true;

      	  // 유효성 검사
      	  $('#reqTable input[required]').each(function() {
      	    if ($(this).val().trim() === '') {
      	      isValid = false;
      	      return false; // 유효성 검사 실패 시 반복문 종료
      	    }
      	  });

      	  if (isValid) {
      	    $('#fr').submit();
      	  } else {
     		 	 Swal.fire({
  				title: "<div style='color:#495057;font-size:20px;font-weight:lighter'>" + "항목을 모두 입력하세요"+ "</div>",
  				icon: 'info',
  				width: '300px',
  			 });
      	  }
      	}
        var counter = 0;
	
        function deleteRow(button) {
			  var row1 = button.parentNode.parentNode;
			  row1.parentNode.removeChild(row1);
			  //counter--;
			}	
	    	
	  	
        $(document).ready(function() {
        	
        	//테이블 항목들 인덱스 부여
    		$('table tr').each(function(index){
    			var num = "<c:out value='${paging.nowPage}'/>";
    			var num2 = "<c:out value='${paging.cntPerPage}'/>";
    			$(this).find('td:first').text(((num-1)*num2) + index-1);
    		});
        	
    		// 추가 시 필요한 변수들

           
            var codeNum = 0;
        	var reqCode = 0;
            
            // 추가 버튼 클릭 시 row 생성
           
            

            // 버튼 클릭시 addRow() 기능 불러오기
            $('#addButton').click(function() {
            	 
            	event.preventDefault();
            	$('#delete').attr("disabled", true);
				$('#modify').attr("disabled", true);
				
				$.ajax({
  				  url: "${pageContext.request.contextPath}requirement/reqCode",
  				  method: "GET",
  				  dataType: "text",
  				  success: function(data) {
  				    // Ajax 요청 안에서 데이터를 받아와서 변수에 할당 및 후속 작업 수행
  				    codeNum = data;
  				    console.log("Ajax 내부에서의 codeNum:", codeNum); // Ajax 내부에서의 codeNum: [받아온 데이터]
  				    
  				    // 변수에 할당된 데이터를 기반으로 추가 작업 수행
  				    someFunction(codeNum);
  				  }
  				}); // ajax 끝

  				function someFunction(data) {
  					 codeNum = data; // 외부에서의 codeNum: [받아온 데이터]
 						 var num = parseInt(codeNum.substring(2)) + counter+1; // 문자열을 숫자로 변환하여 1 증가
 						 var paddedNum = padNumber(num, codeNum.length - 2); // 숫자를 패딩하여 길이 유지
 						 reqCode = codeNum.charAt(0) + codeNum.charAt(1) + paddedNum.toString(); // 패딩된 숫자를 다시 문자열로 변환
 			             addRow();
 			             counter++;
  				} // someFunction(data)
  				
  				$('#save').click(function() {
  					submitForm();
				}); //save
				
            });
            
            function addRow() {
            	
                var row = '<tr>' +
                	
                	'<td><span class="delete-button" onclick="deleteRow(this)">X</span></td>' + 
                	'<input type="hidden" name="reqs[' + counter + '].rawCode" id = "rawCode'+counter+'" required>' +
                    '<td><input type="text" name="reqs[' + counter + '].reqCode" " value="'+ reqCode +'" readonly required class="input-fieldb"></td>' +
                    '<input type="hidden" name="reqs[' + counter + '].prodCode" id= "prodCode'+counter+'">' +
                    '<td><input type="text" name="reqs[' + counter + '].prod.prodName" id = "prodName'+counter+'" readonly onclick=serchProd("prodCode'+counter+'"); class="input-fielda"></td>' +
                    '<td><input type="text" name="reqs[' + counter + '].raw.rawName" id="rawName'+counter+'" readonly onclick=serchRaw("rawCode'+counter+'"); class="input-fielda"></td>' +
                    '<td><input type="number" name="reqs[' + counter + '].reqAmount" required class="input-fieldb"></td>' +
                    '<td><input type="text" name="reqs[' + counter + '].reqMemo" class="input-fieldb"></td>' +
                    
                    '</tr>';
                    
                $('#reqTable').append(row);
                
            	 // 테이블이 많이 생성되면 스크롤바 생성
                var table = document.getElementById('reqTable');
                table.scrollTop = table.scrollHeight;
				
            }
            
            
            
            function padNumber(number, length) {
                var paddedNumber = number.toString();
                while (paddedNumber.length < length) {
                    paddedNumber = "0" + paddedNumber;
                }
                return paddedNumber;
       		 } // padNumber(number, length)
            
            // =============================================================================================================
 

        	//취소버튼 -> 리셋
			$('#cancle').click(function(){
				$('#fr').each(function(){
					this.reset();
					//removeRow();
					
				});
			}); //cacle click
			
			
			
			
			
			
			// 삭제 기능
			$('#delete').click(function(event){
				event.preventDefault();
				$('#addButton').attr("disabled", true);
				$('#modify').attr("disabled", true);
				
				// td 요소 중 첫번째 열 체크박스로 바꾸고 해당 행의 작업 지시 코드 저장
				$('table tr').each(function(){
					var code = $(this).find('td:nth-child(2)').text();
					
					var tbl = "<input type='checkbox' name='selected' value='";
					tbl += code;
					tbl += "'>";
					
					$(this).find('th:first').html("<input type='checkbox' id='selectAll'>");
					$(this).find('td:first').html(tbl);
				});
				
				$('#selectAll').click(function() {
					var checkAll = $(this).is(":checked");
					
					if(checkAll) {
						$('input:checkbox').prop('checked', true);
					} else {
						$('input:checkbox').prop('checked', false);
					}
				});
				
				
				//저장 -> 삭제
				$('#save').click(function() {
					
					var checked = [];
					
					$('input[name=selected]:checked').each(function(){
						checked.push($(this).val());
					});
					
//	 				alert(checked);
					
					if(checked.length > 0) {
						Swal.fire({
							  title: "<div style='color:#495057;font-size:20px;font-weight:lighter'>" + "총" +checked.length+"건\n정말 삭제하시겠습니까?"+ "</div>",
									  // “<div style=’color:#f00;font-size:15px’>” + msg + “</div>”,    //  HTML & CSS 로 직접수정
							  icon: 'info', // 아이콘! 느낌표 색? 표시?
							  showDenyButton: true,
							  confirmButtonColor: '#17A2B8', // confrim 버튼 색깔 지정
							  cancelButtonColor: '#73879C', // cancel 버튼 색깔 지정
							  confirmButtonText: 'Yes', // confirm 버튼 텍스트 지정
//	 						  cancelButtonText: '아니오', // cancel 버튼 텍스트 지정
							  width : '300px', // alert창 크기 조절
							  
							}).then((result) => {
						
						 /* confirm => 예 눌렀을 때  */
						  if (result.isConfirmed) {
							  
						  
							$.ajax({
		 						url: "${pageContext.request.contextPath}/requirementDelete",
		 						type: "POST",
		 						data: {checked : checked},
		 						dataType: "text",	
		 						success: function () {
		 							Swal.fire({
										  title: "<div style='color:#495057;font-size:20px;font-weight:lighter'>"+ "총" +checked.length+"건 삭제 완료",
										  icon: 'success',
										  width : '300px',
										}).then((result) => {
										  if (result.isConfirmed) {
										    location.reload();
										  }
										});
								},
								error: function () {
									Swal.fire({
										title : "<div style='color:#495057;font-size:20px;font-weight:lighter'>"+ "삭제 중 오류가 발생했습니다",
										icon : 'question',
										width: '300px',
										});
									
								}
							});//ajax
							  } else if (result.isDenied) {
									Swal.fire({
									title : "<div style='color:#495057;font-size:20px;font-weight:lighter'>"+ "삭제가 취소되었습니다",
									icon : 'error',
									width: '300px',
									});
						}// if(confirm)
					});		
							
					}// 체크OOO
					else{
						Swal.fire({
							title : "<div style='color:#495057;font-size:20px;font-weight:lighter'>"+ "선택된 항목이 없습니다",
							icon : 'warning',
							width: '300px',
							});
					}// 체크 XXX
		
				}); // save
				
						 
// 						Swal.fire({
// 						  title: "<div style='color:#3085d6;font-size:20px'>" + "총" +checked.length+"행\n정말 삭제하시겠습니까?"+ "</div>",
// 								  // “<div style=’color:#f00;font-size:15px’>” + msg + “</div>”,    //  HTML & CSS 로 직접수정
// 						  icon: 'warning', // 아이콘! 느낌표 색? 표시?
// 						  showDenyButton: true,
// 						  confirmButtonColor: '#3085d6', // confrim 버튼 색깔 지정
// 						  cancelButtonColor: '#d33', // cancel 버튼 색깔 지정
// 						  confirmButtonText: '예', // confirm 버튼 텍스트 지정
// 						  cancelButtonText: '아니오', // cancel 버튼 텍스트 지정
// 						  width : '300px' // alert창 크기 조절
						   
// 						}).then((result) => {
// 						 /* confirm => 예 눌렀을 때  */
// 						  if (result.isConfirmed) {
							  
// 							  $.ajax({
// 									url: "/requirement/rawMaterialDelete",
// 									type: "post",
// 									data: {checked:checked},
// 									dataType: "text",
// 									success: function() {
// 										Swal.fire({
// 											  title:  "총" +checked.length+"건 삭제 완료",
// 											  icon: 'error',
// 											}).then((result) => {
// 											  if (result.isConfirmed) {
// 											    location.reload();
// 											  }
// 											});
// 									},
// 									error: function() {
// 										Swal.fire('삭제 실패!.', '', 'success')
// 									}
// 								}); //ajax
							  
// 						  } else if (result.isDenied) {
// 						    Swal.fire('삭제가 취소되었습니다.', '', 'info')
// 						  }
// 						});
						
						
// 					} //체크된거 있을대
// 					else {
// 						 Swal.fire('선택된 항목이 없습니다.', '', 'info')
// 					} //체크된거 없을때
					
// 				}); //save
				
				//취소 -> 리셋
				$('#cancle').click(function(){
					$('input:checkbox').prop('checked', false);
				});
				
			}); //delete click
			
			/////////////// 수정 //////////////////////////////
			var isExecuted = false;
			
			//수정버튼 클릭
			$('#modify').click(function() {
				event.preventDefault();
				$('#addButton').attr("disabled", true);
				$('#delete').attr("disabled", true);

				//행 하나 클릭했을 때	
				$('table tr:not(:first-child)').click(function() {
					
					//하나씩만 선택 가능
					if(!isExecuted) {
						isExecuted = true;
								
						$(this).addClass('selected');
						//품목코드 저장
						let updateCode = $(this).find('#reqCode').text().trim();
						console.log(updateCode);
		
						var jsonData = {
							reqCode : updateCode
						};
		
						var self = $(this);
		
						$.ajax({
							url : "${pageContext.request.contextPath}/requirement/reqOne",
							type : "post",
							contentType : "application/json; charset=UTF-8",
							dataType : "json",
							data : JSON.stringify(jsonData),
							success : function(data) {
								// alert("*** 아작스 성공 ***");
								var sum = 0;
								
								var preVOs = [
										data.reqCode,
										data.prodCode,
										data.prod.prodName,
										data.raw.rawName,
										data.reqAmount,
										data.reqMemo,
										data.rawCode
										];
								
							
		
								var names = [
										"reqCode",
										"prodCode",
										"prodName",
										"rawName",
										"reqAmount",
										"reqMemo",
										"rawCode"
										];
		
								//tr안의 td 요소들 input으로 바꾸고 기존 값 띄우기
								
								self.find('td').each(function(idx,item) {
									if (idx > 0) {
										inputCng($(this),"text",names[idx - 1],preVOs[idx - 1]);
// 									
										if(idx==4){
											var row = '<input type="hidden" name="'+names[7]+'" value="'+preVOs[7]+'" id="rawCode">'
											$(".selected").append(row);
										}


									} //라인코드부터 다 수정 가능하게
		
								}); // self.find(~~)
								
								
		
								//품번 검색 
								$('#prodCode').click(function() {
									openWindow("prod","prodCode");
								}); //prodCode click
								
								//품번 검색 팝업(raw)
								$('#rawName').click(function() {
									openWindow2("raw", "search_raw");
								}); //rawCode click
		
							},
							error : function(data) {
								alert("아작스 실패 ~~");
							}
						}); //ajax
		
						//저장버튼 -> form 제출
						$('#save').click(function() {
		
							$('#fr').attr("action","${pageContext.request.contextPath}/requirement/reqModify");
							$('#fr').attr("method","post");
							$('#fr').submit();
		
						}); //save

					} //하나씩만 선택 가능
						
						
					//취소버튼 -> 리셋
					$('#cancle').click(function() {
						$('#fr').each(function() {
							this.reset();
						});
					}); //cancle click

				}); //tr click

			}); //modify click

            
        });