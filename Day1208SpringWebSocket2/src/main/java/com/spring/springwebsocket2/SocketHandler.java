package com.spring.springwebsocket2;

import java.util.HashSet;
import java.util.Map;
import java.util.Set;

import org.springframework.web.socket.CloseStatus;
import org.springframework.web.socket.WebSocketMessage;
import org.springframework.web.socket.WebSocketSession;
import org.springframework.web.socket.handler.TextWebSocketHandler;

public class SocketHandler extends TextWebSocketHandler { //�ڵ彦��Ŀ �����ϸ� �����ڵ鷯�� ���� ����� (�ڵ�ȣ�� �޼ҵ� - �����ڵ鷯, �ڵ彦��ũ���ͼ���)

		private Set<WebSocketSession> sessionSet = new HashSet<WebSocketSession>();
		
		public SocketHandler() {
			super();
		}
		
		public void afterConnectionClosed(WebSocketSession session, CloseStatus status) throws Exception{
			super.afterConnectionClosed(session, status);
			System.out.println("���� ��");
			sessionSet.remove(session);
		}
		
		public void afterConnectionEstablished(WebSocketSession session) throws Exception{ //���ἳ���� �Ǿ�����
			super.afterConnectionEstablished(session);
			System.out.println("���� �߰�");

			sessionSet.add(session);
		}
		
		public void handleMessage(WebSocketSession session, WebSocketMessage<?> message) throws Exception{ 
			super.handleMessage(session, message);
			
			Map<String, Object> map = session.getAttributes();
			
			String userId = (String)map.get("userId");
			System.out.println("userId" + userId);
			for(WebSocketSession client_session : this.sessionSet) { //Set : ����, �ߺ��Ǵ� ���� ������ ����
				if(client_session.isOpen()) {
					try {
						client_session.sendMessage(message); // �������� Ŭ���̾�Ʈ�� �޽��� ����
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
