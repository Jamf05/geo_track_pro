abstract class Dto {
  const Dto();

  const factory Dto.empty() = EmptyDto;
}

final class EmptyDto extends Dto {
  const EmptyDto();
}
