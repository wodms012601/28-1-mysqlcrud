			//한글 체크 함수
			function hangulChar(str) {
				var c = str.charCodeAt(0); //입력한 값의 유니코드값을 리턴
				if( 0x1100<=c && c<=0x11FF ) return true; //한글 자모
				if( 0x3130<=c && c<=0x318F ) return true; //한글 자모
				if( 0xAC00<=c && c<=0xD7AF ) return true; //한글 음절
				return false;
			}
			
			//이름 한글 체크 함수
			function nameCheck(){
				var name = document.getElementById("name").value; //text박스에 적은 값을 id를 통해 가져옴
				var nameSpan = document.getElementById("nameSpan"); //결과값을 넣을 span태그의 id
				  
				if(name == ""){
					nameSpan.innerHTML = "적어주세요";
				} else if(hangulChar(name)) { 
					nameSpan.innerHTML = "잘했어요";
				} else {
					nameSpan.innerHTML = "한글을 적어주세요";
				}
			}
			
			//주소 한글 체크 함수
			function addrCheck(){
				var addr = document.getElementById("addr").value; //text박스에 적은 값을 id를 통해 가져옴
				var addrSpan = document.getElementById("addrSpan"); //결과값을 넣을 span태그의 id
				  
				if(addr == ""){
					addrSpan.innerHTML = "적어주세요";
				} else if(hangulChar(addr)) { 
					addrSpan.innerHTML = "잘했어요";
				} else {
					addrSpan.innerHTML = "한글을 적어주세요";
				}
			}
			
			function onlyNumber(event){ // 오직 숫자만 입력
				event = event || window.event;
				// 다른 브라우저들이 event를 다루는 방법이 서로 다르기 때문에
				// 인수로 전달받은 event가  유효하면 이를 event에 스스로를 다시 한 번 대입하고 브라우저에서 사용할 경우 념겨받은 event가 무효한 경우 window.event로 대신하겠다는 것이다.
				var keyID = (event.which) ? event.which : event.keyCode;
				// event.keyCode 입력된 키의 코드 값을 얻는다.
				// 예를 들어 키보드의 0~9의 숫자는 48~57의 키코드를 가지며, 오른쪽쪽 숫자키 패드의 0~9는 96~105의 키코드를 갖는다.
				if ( (keyID >= 48 && keyID <= 57) || (keyID >= 96 && keyID <= 105) || keyID == 8 || keyID == 46 || keyID == 37 || keyID == 39 )
					return;
				else
					return false;
			}
			function removeChar(event) { // 숫자가 아닌 문자 제거
				event = event || window.event;
				var keyID = (event.which) ? event.which : event.keyCode;
				if ( keyID == 8 || keyID == 46 || keyID == 37 || keyID == 39 )
					// 8=Backspace, 46=Delete, 37=왼쪽 화살표, 39=오른쪽 화살표
					return;
				else
					event.target.value = event.target.value.replace(/[^0-9]/g, "");
			}