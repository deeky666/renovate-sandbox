<?php

namespace TheCodingMachine\GraphQLite\Bundle\Tests;

use Symfony\Component\Cache\Adapter\ApcuAdapter;
use function json_decode;
use PHPUnit\Framework\TestCase;
use Symfony\Component\HttpFoundation\Request;
use TheCodingMachine\GraphQLite\Schema;

/**
 * This test class is supposed to work even if the security bundle is not installed in the project.
 * It is here to check we don't have hidden dependencies on this bundle and that it remains optional.
 */
class NoSecurityBundleTest extends TestCase
{
    public function testServiceWiring(): void
    {
        // tech debt: for some reason when we're running full test suite
        // - from APCu cache we're getting old controllers for available graphql and this fails test
        if (ApcuAdapter::isSupported()) {
            $apcu = new ApcuAdapter();
            $apcu->clear();
        }

        $kernel = new GraphQLiteTestingKernel(true, null, false, null, true, null, null, ['TheCodingMachine\\GraphQLite\\Bundle\\Tests\\NoSecurityBundleFixtures\\Controller\\']);
        $kernel->boot();
        $container = $kernel->getContainer();

        $schema = $container->get(Schema::class);
        $this->assertInstanceOf(Schema::class, $schema);
        $schema->assertValid();

        $request = Request::create('/graphql', 'GET', ['query' => '
        { 
          echoMsg(message: "Hello world")
        }']);

        $response = $kernel->handle($request);

        $result = json_decode($response->getContent(), true);

        $this->assertSame([
            'data' => [
                'echoMsg' => 'Hello world'
            ]
        ], $result);
    }
}
