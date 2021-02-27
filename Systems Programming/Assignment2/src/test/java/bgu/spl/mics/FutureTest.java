package bgu.spl.mics;

import static org.junit.Assert.*;

import java.util.concurrent.TimeUnit;

import org.junit.Before;
import org.junit.Test;

public class FutureTest {
	
	private static Future<Integer> out;

	@Before
	public void setUp() throws Exception {
		out = new Future<Integer>();
	}


	@Test
	public void testFuture() {	
		assertTrue(out!=null);  // expected to init out
	}

	@Test
	public void testGet() {
		out.setVal(2);
		assertTrue(out.get()==2);
	}

	@Test
	public void testResolve() {
		out.resolve(3);
		assertTrue(out.get()==3);
	}

	@Test
	public void testIsDone() {
		assertFalse(out.isDone()); // before resolving result
		out.setVal(5);
		assertTrue(out.isDone()); // after resolving result
	}

	@Test
	public void testGetLongTimeUnit() {
		// before resolving result, expected to return null after timeout
		assertNull(out.get(2, TimeUnit.MILLISECONDS)); 
		// after resolving, expected to return value
		out.setVal(7);
		assertTrue(out.get(2, TimeUnit.MILLISECONDS)==7);
	}

}