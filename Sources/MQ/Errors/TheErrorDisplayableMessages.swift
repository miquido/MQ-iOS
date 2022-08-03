/// ``TheErrorDisplayableMessages`` is a container
/// holding default ``DisplayableMessage`` for errors
/// based on the error type.
/// Default implementation of ``TheError.displayableMessage``
/// uses value from this container unless
/// specific error implementation overrides it.
/// This allows to customize displayable messages
/// for unowned errors which implementation comes
/// from external source. It can be also used
/// as default message source for TheError implementations.
/// Message for each error type can be set only once
/// and only unless message was already requested for
/// a given type. Default message for each type is
/// the error type name if no value was set.
public enum TheErrorDisplayableMessages {

	@usableFromInline internal static let storage: CriticalSection<Dictionary<AnyHashable, DisplayableString>> = .init(
		.init()
	)

	/// Get the message for given error.
	///
	/// Access ``DisplayableString`` associated
	/// with given error type or its group.
	/// If no message was set for requested type
	/// its group will be checked for a message.
	/// If requested error group does not have
	/// associated message, error name will be used instead.
	/// In orded to customize messages use
	/// ``TheErrorDisplayableMessages.setMessage(_:for:)`` or
	/// ``TheErrorDisplayableMessages.setMessage(_:forGroup:)``.
	@inlinable @Sendable public static func message<ErrorType>(
		for _: ErrorType.Type
	) -> DisplayableString
	where ErrorType: TheError {
		self.storage.access { (messages: inout Dictionary<AnyHashable, DisplayableString>) -> DisplayableString in
			if let message: DisplayableString = messages[ErrorType.id] {
				return message
			}
			else if let firstMatchingGroupIdentifier: TheErrorGroup.Identifier = ErrorType.group.firstMatchingIdentifier(
				messages.keys.contains(_:)
			),
				let message: DisplayableString = messages[firstMatchingGroupIdentifier]
			{
				messages[ErrorType.id] = message
				return message
			}
			else if let message: DisplayableString = messages[TheErrorGroup.default] {
				messages[ErrorType.id] = message
				return message
			}
			else {
				let message: DisplayableString = "\(ErrorType.self)"
				messages[ErrorType.id] = message
				return message
			}
		}
	}

	/// Set the message for given error.
	///
	/// Associate message with given error type.
	/// Message can be set only once and only
	/// if it was not requested before.
	///
	/// - Note: Assigned message will be cached
	/// and reused. Make sure that it does not
	/// provide dynamic value that is expected
	/// to be changing over time.
	@inlinable @Sendable public static func setMessage<ErrorType>(
		_ message: DisplayableString,
		for _: ErrorType.Type
	) where ErrorType: TheError {
		self.storage.access { (messages: inout Dictionary<AnyHashable, DisplayableString>) -> Void in
			runtimeAssert(
				!messages.keys.contains(ErrorType.id),
				message: "Error message can be assigned only once."
			)
			messages[ErrorType.id] = message
		}
	}

	/// Set the message for given error group.
	///
	/// Associate message with given error group.
	/// Group intersections are not verified,
	/// group must be equal to provided in order
	/// to use customized message.
	/// Message can be set only once.
	///
	/// - Note: Assigned message will be cached
	/// and reused. Make sure that it does not
	/// provide dynamic value that is expected
	/// to be changing over time.
	@inlinable @Sendable public static func setMessage(
		_ message: DisplayableString,
		forGroup groupIdentifier: TheErrorGroup.Identifier
	) {
		self.storage.access { (messages: inout Dictionary<AnyHashable, DisplayableString>) -> Void in
			runtimeAssert(
				!messages.keys.contains(groupIdentifier),
				message: "Error message can be assigned only once."
			)
			messages[groupIdentifier] = message
		}
	}

	/// Set the default message for errors.
	///
	/// Associate message with the default error group.
	/// If default message is not set error type will be
	/// used as the message.
	/// Message can be set only once.
	///
	/// - Note: Assigned message will be cached
	/// and reused. Make sure that it does not
	/// provide dynamic value that is expected
	/// to be changing over time.
	@inlinable @Sendable public static func setDefaultMessage(
		_ message: DisplayableString
	) {
		self.storage.access { (messages: inout Dictionary<AnyHashable, DisplayableString>) -> Void in
			runtimeAssert(
				!messages.keys.contains(TheErrorGroup.default),
				message: "Error message can be assigned only once."
			)
			messages[TheErrorGroup.default] = message
		}
	}
}
