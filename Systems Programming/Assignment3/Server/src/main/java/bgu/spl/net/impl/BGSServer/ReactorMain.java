package bgu.spl.net.impl.BGSServer;

import bgu.spl.net.api.MessageEncoderDecoderImpl;
import bgu.spl.net.api.bidi.BidiMessagingProtocolImpl;
import bgu.spl.net.api.bidi.UsersData;
import bgu.spl.net.srv.Server;

public class ReactorMain {

	public static void main(String[] args) {
		UsersData dataBase = new UsersData();

		Server.reactor(
				Integer.parseInt(args[1]),
				Integer.parseInt(args[0]), //port
				() -> new BidiMessagingProtocolImpl(dataBase), //protocol factory
				() -> new MessageEncoderDecoderImpl() //message encoder decoder factory
				).serve();
	}
}
