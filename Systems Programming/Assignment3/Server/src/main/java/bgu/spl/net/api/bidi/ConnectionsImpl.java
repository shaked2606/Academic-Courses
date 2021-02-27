package bgu.spl.net.api.bidi;

import java.util.HashMap;
import java.util.Map;

import bgu.spl.net.srv.bidi.ConnectionHandler;

public class ConnectionsImpl<T> implements Connections<T> {
	
	private HashMap<Integer, ConnectionHandler<T>> activeClients;
	private Integer idCounter; 
	
	public ConnectionsImpl() {
		this.activeClients = new HashMap<Integer, ConnectionHandler<T>>();
		this.idCounter = 0;
	}
	
	@Override
	public boolean send(int connectionId, T msg) {
		boolean output = false;
		ConnectionHandler<T> connection = activeClients.get(connectionId);
		
		if (connection!=null) {
			activeClients.get(connectionId).send(msg);
			output = true;
		}
		
		return output;
	}

	@Override
	public void broadcast(T msg) {
		for (Map.Entry<Integer,ConnectionHandler<T>> connection: activeClients.entrySet()) {
			connection.getValue().send(msg);
		}
	}
	
	// connects and returns connection ID
	public void connect(ConnectionHandler<T> connection) {
		Integer connectionId = idCounter;
		idCounter++;
		activeClients.put(connectionId, connection);
	}

	@Override
	public void disconnect(int connectionId) {
		activeClients.remove(connectionId);	
	}
	
	public Integer getConnectionID(ConnectionHandler<T> connection) {
		for(Map.Entry<Integer, ConnectionHandler<T>> CurrConnection:activeClients.entrySet()) {
			if(CurrConnection.getValue() == connection) {
				return CurrConnection.getKey();
			}
		}
		return null;
	}
	

}
