#if canImport(Foundation)

	import class Foundation.NSRecursiveLock

	extension Lock {

		/// Crate an instance of ``Lock`` backed by provided ``NSRecursiveLock`` instance.
		///
		/// This method can be used to create both new locks and to wrap existing instances of ``NSRecursiveLock``.
		///
		/// - Parameter lock: Instance of ``NSRecursiveLock`` that will be used to perform locking.
		/// New instance of ``NSRecursiveLock`` is made as a default argument.
		/// - Returns: Instance of ``Lock`` using provided ``NSRecursiveLock``.
		public static func nsRecursiveLock(
			_ lock: NSRecursiveLock = .init()
		) -> Self {
			Self(
				acquire: lock.lock,
				tryAcquire: lock.try,
				release: lock.unlock
			)
		}
	}
#endif
