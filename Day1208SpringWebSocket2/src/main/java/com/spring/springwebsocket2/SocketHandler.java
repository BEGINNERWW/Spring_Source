package com.spring.springwebsocket2;

import java.util.HashSet;
import java.util.Map;
import java.util.Set;

import org.springframework.web.socket.CloseStatus;
import org.springframework.web.socket.WebSocketMessage;
import org.springframework.web.socket.WebSocketSession;
import org.springframework.web.socket.handler.TextWebSocketHandler;

public class SocketHandler extends TextWebSocketHandler { //핸드쉐이커 실행하면 소켓핸들러도 동시 실행됨 (자동호출 메소드 - 소켓핸들러, 핸드쉐이크인터셉터)

		private Set<WebSocketSession> sessionSet = new HashSet<WebSocketSession>();
		
		public SocketHandler() {
			super();
		}
		
		public void afterConnectionClosed(WebSocketSession session, CloseStatus status) throws Exception{
			super.afterConnectionClosed(session, status);
			System.out.println("세션 끝");
			sessionSet.remove(session);
		}
		
		public void afterConnectionEstablished(WebSocketSession session) throws Exception{ //연결설정이 되었을때
			super.afterConnectionEstablished(session);
			System.out.println("세션 추가");

			sessionSet.add(session);
		}
		
		public void handleMessage(WebSocketSession session, WebSocketMessage<?> message) throws Exception{ 
			super.handleMessage(session, message);
			
			Map<String, Object> map = session.getAttributes();
			
			String userId = (String)map.get("userId");
			System.out.println("userId" + userId);
			for(WebSocketSession client_session : this.sessionSet) { //Set : 집합, 중복되는 값은 가질수 없음
				if(client_session.isOpen()) {
					try {
						client_session.sendMessage(message); // 서버에서 클라이언트에 메시지 보냄
					}catch(Exception ignored) {
						System.out.println("fail to send message"+ ignored);
					}
				}
			}
		}
		
		public void handleTransportError(WebSocketSession session, Throwable exception) throws Exception{
			System.out.println("web socket error!" + exception);
		}
		
		public boolean supportsPartialMessage() {
			System.out.println("call method!");
			
			return false;
		}
}
