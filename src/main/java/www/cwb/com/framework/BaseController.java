package www.cwb.com.framework;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

public abstract class BaseController {
	protected Logger logger = LoggerFactory.getLogger(this.getClass());

	protected void debug(Object obj) {
		logger.debug(obj.toString());
	}


}
